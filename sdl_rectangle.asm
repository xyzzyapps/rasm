; ============================================================================
; Readable Assembly - SDL Rectangle Game
; ============================================================================
; A simple game that draws a colored rectangle on screen and moves it with
; arrow keys. Demonstrates SDL integration with readable assembly macros.
;
; Build (Linux):
;   nasm -f elf64 sdl_rectangle.asm -o sdl_rectangle.o
;   gcc sdl_rectangle.o -o sdl_rectangle -lSDL2 -no-pie
;
; Build (Windows with MinGW):
;   nasm -f win64 sdl_rectangle.asm -o sdl_rectangle.o
;   gcc sdl_rectangle.o -o sdl_rectangle.exe -lSDL2
; ============================================================================

%include "readable_macros.nasm"

; ============================================================================
; EXTERNAL SDL FUNCTIONS (C ABI)
; ============================================================================
extern SDL_Init
extern SDL_CreateWindow
extern SDL_CreateRenderer
extern SDL_SetRenderDrawColor
extern SDL_RenderClear
extern SDL_RenderFillRect
extern SDL_RenderPresent
extern SDL_PollEvent
extern SDL_Delay
extern SDL_Quit
extern SDL_GetKeyboardState
extern SDL_DestroyRenderer
extern SDL_DestroyWindow

extern exit
extern printf

; ============================================================================
; CONSTANTS
; ============================================================================
%define WINDOW_WIDTH    800
%define WINDOW_HEIGHT   600
%define RECT_SIZE       50
%define MOVE_SPEED      5
%define BG_RED          30
%define BG_GREEN        30
%define BG_BLUE         30
%define BG_ALPHA        255
%define RECT_RED        0
%define RECT_GREEN      200
%define RECT_BLUE       255
%define RECT_ALPHA      255
%define SDL_INIT_VIDEO  0x00000020

; ============================================================================
; DATA SECTION
; ============================================================================
section .data
    window_title      db  "Readable Assembly - SDL Rectangle Game", 0
    error_init        db  "Failed to initialize SDL: %s", 10, 0
    error_window      db  "Failed to create window: %s", 10, 0
    error_renderer    db  "Failed to create renderer: %s", 10, 0
    success_msg       db  "SDL initialized successfully!", 10, 0

    ; SDL_Rect structure (x, y, w, h)
    rect_x            dd  375        ; Start centered: (800-50)/2
    rect_y            dd  275        ; Start centered: (600-50)/2
    rect_w            dd  RECT_SIZE
    rect_h            dd  RECT_SIZE

    ; Keyboard state pointer
    keyboard_state    dq  0

; ============================================================================
; BSS SECTION
; ============================================================================
section .bss
    sdl_window        resq  1
    sdl_renderer      resq  1
    event_storage     resb  56     ; SDL_Event size
    rect_storage      resb  16     ; SDL_Rect size

; ============================================================================
; TEXT SECTION
; ============================================================================
section .text
    global main

; ============================================================================
; MAIN - Entry Point
; ============================================================================
main:
    ; --- Prologue ---
    push-onto-stack register-rbp
    move    register-rbp, register-rsp

    ; --- Initialize SDL ---
    move    register-di, SDL_INIT_VIDEO
    call-procedure SDL_Init
    compare register-rax, 0
    jump-if-less init_failed

    ; --- Create Window ---
    move    register-di, window_title
    move    register-si, -2147483648  ; SDL_WINDOWPOS_UNDEFINED
    move    register-dx, -2147483648  ; SDL_WINDOWPOS_UNDEFINED
    move    register-r10d, WINDOW_WIDTH
    move    register-r8d, WINDOW_HEIGHT
    move    register-r9d, 0           ; flags
    sub     register-rsp, 8           ; Align stack
    call-procedure SDL_CreateWindow
    add     register-rsp, 8
    compare register-rax, 0
    jump-if-equal window_failed
    move    [sdl_window], register-rax

    ; --- Create Renderer ---
    move    register-rdi, [sdl_window]
    move    register-rsi, -1          ; -1 = first driver
    move    register-rdx, 0           ; flags
    sub     register-rsp, 8
    call-procedure SDL_CreateRenderer
    add     register-rsp, 8
    compare register-rax, 0
    jump-if-equal renderer_failed
    move    [sdl_renderer], register-rax

    ; --- Get Keyboard State ---
    move    register-rdi, 0           ; NULL
    call-procedure SDL_GetKeyboardState
    move    [keyboard_state], register-rax

    ; ========================================================================
    ; GAME LOOP
    ; ========================================================================
game_loop:
    ; --- Check for quit events ---
    move    register-rdi, event_storage
    call-procedure SDL_PollEvent
    compare register-rax, 0
    jump-if-not-equal check_events

    ; --- No events, process input ---
    call-procedure process_input

    ; --- Clear screen ---
    move    register-rdi, [sdl_renderer]
    move    register-esi, BG_RED
    move    register-edx, BG_GREEN
    move    register-ecx, BG_BLUE
    move    register-r8d, BG_ALPHA
    call-procedure SDL_SetRenderDrawColor

    move    register-rdi, [sdl_renderer]
    call-procedure SDL_RenderClear

    ; --- Draw rectangle ---
    call-procedure draw_rectangle

    ; --- Present renderer ---
    move    register-rdi, [sdl_renderer]
    call-procedure SDL_RenderPresent

    ; --- Frame delay (16ms ~ 60fps) ---
    move    register-edi, 16
    call-procedure SDL_Delay

    ; --- Loop ---
    jump    game_loop

; ============================================================================
; CHECK EVENTS
; ============================================================================
check_events:
    ; Check event type (first 4 bytes of SDL_Event)
    move    register-rax, [event_storage]
    compare register-eax, 256         ; SDL_QUIT
    jump-if-equal cleanup

    compare register-eax, 768         ; SDL_KEYDOWN
    jump-if-equal check_escape

    jump    game_loop

check_escape:
    ; Check if Escape key was pressed (scancode 41)
    move    register-rax, [event_storage + 8]  ; keysym.scancode
    compare register-eax, 41           ; SDL_SCANCODE_ESCAPE
    jump-if-equal cleanup
    jump    game_loop

; ============================================================================
; PROCESS INPUT
; ============================================================================
process_input:
    ; Prologue
    push-onto-stack register-rbp
    move    register-rbp, register-rsp
    push-onto-stack register-rbx

    move    register-rbx, [keyboard_state]

    ; --- Check Up Arrow (scancode 82) ---
    move    register-al, [register-rbx + 82]
    compare register-al, 0
    jump-if-equal check_down
    ; Move up
    move    register-eax, [rect_y]
    subtract register-eax, MOVE_SPEED
    move    [rect_y], register-eax

check_down:
    ; --- Check Down Arrow (scancode 81) ---
    move    register-al, [register-rbx + 81]
    compare register-al, 0
    jump-if-equal check_left
    ; Move down
    move    register-eax, [rect_y]
    add     register-eax, MOVE_SPEED
    move    [rect_y], register-eax

check_left:
    ; --- Check Left Arrow (scancode 80) ---
    move    register-al, [register-rbx + 80]
    compare register-al, 0
    jump-if-equal check_right
    ; Move left
    move    register-eax, [rect_x]
    subtract register-eax, MOVE_SPEED
    move    [rect_x], register-eax

check_right:
    ; --- Check Right Arrow (scancode 79) ---
    move    register-al, [register-rbx + 79]
    compare register-al, 0
    jump-if-equal clamp_position
    ; Move right
    move    register-eax, [rect_x]
    add     register-eax, MOVE_SPEED
    move    [rect_x], register-eax

clamp_position:
    ; --- Clamp X position ---
    move    register-eax, [rect_x]
    compare register-eax, 0
    jump-if-greater-or-equal clamp_x_max
    move    dword [rect_x], 0

clamp_x_max:
    move    register-eax, [rect_x]
    compare register-eax, WINDOW_WIDTH - RECT_SIZE
    jump-if-less-or-equal clamp_y_min
    move    dword [rect_x], WINDOW_WIDTH - RECT_SIZE

clamp_y_min:
    ; --- Clamp Y position ---
    move    register-eax, [rect_y]
    compare register-eax, 0
    jump-if-greater-or-equal clamp_y_max
    move    dword [rect_y], 0

clamp_y_max:
    move    register-eax, [rect_y]
    compare register-eax, WINDOW_HEIGHT - RECT_SIZE
    jump-if-less-or-equal process_done
    move    dword [rect_y], WINDOW_HEIGHT - RECT_SIZE

process_done:
    pop-from-stack register-rbx
    move    register-rsp, register-rbp
    pop-from-stack register-rbp
    return-from-procedure

; ============================================================================
; DRAW RECTANGLE
; ============================================================================
draw_rectangle:
    ; Prologue
    push-onto-stack register-rbp
    move    register-rbp, register-rsp

    ; Copy rect values to rect_storage
    move    register-eax, [rect_x]
    move    [rect_storage], register-eax
    move    register-eax, [rect_y]
    move    [rect_storage + 4], register-eax
    move    register-eax, [rect_w]
    move    [rect_storage + 8], register-eax
    move    register-eax, [rect_h]
    move    [rect_storage + 12], register-eax

    ; Set draw color to rectangle color
    move    register-rdi, [sdl_renderer]
    move    register-esi, RECT_RED
    move    register-edx, RECT_GREEN
    move    register-ecx, RECT_BLUE
    move    register-r8d, RECT_ALPHA
    call-procedure SDL_SetRenderDrawColor

    ; Fill rectangle
    move    register-rdi, [sdl_renderer]
    lea     register-rsi, [rect_storage]
    call-procedure SDL_RenderFillRect

    ; Epilogue
    move    register-rsp, register-rbp
    pop-from-stack register-rbp
    return-from-procedure

; ============================================================================
; CLEANUP
; ============================================================================
cleanup:
    ; Destroy renderer
    move    register-rdi, [sdl_renderer]
    call-procedure SDL_DestroyRenderer

    ; Destroy window
    move    register-rdi, [sdl_window]
    call-procedure SDL_DestroyWindow

    ; Quit SDL
    call-procedure SDL_Quit

    ; Exit with code 0
    move    register-edi, 0
    call-procedure exit

; ============================================================================
; ERROR HANDLERS
; ============================================================================
init_failed:
    move    register-rdi, error_init
    move    register-rsi, "SDL_Init failed"
    call-procedure printf
    move    register-edi, 1
    call-procedure exit

window_failed:
    move    register-rdi, error_window
    move    register-rsi, "SDL_CreateWindow failed"
    call-procedure printf
    call-procedure SDL_Quit
    move    register-edi, 1
    call-procedure exit

renderer_failed:
    move    register-rdi, error_renderer
    move    register-rsi, "SDL_CreateRenderer failed"
    call-procedure printf
    move    register-rdi, [sdl_window]
    call-procedure SDL_DestroyWindow
    call-procedure SDL_Quit
    move    register-edi, 1
    call-procedure exit
