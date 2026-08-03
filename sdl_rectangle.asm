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

; Windows x64 requires RIP-relative addressing for data symbols
default rel

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
; CALLING CONVENTION ABSTRACTION
; ============================================================================
; Windows x64: args in rcx, rdx, r8, r9, plus 32-byte shadow space.
; System V (Linux): args in rdi, rsi, rdx, rcx, r8, r9.
; We define ARG1..ARG4 so the call sites below work on both platforms.
%ifidn __OUTPUT_FORMAT__, win64
    %define ARG1 rcx
    %define ARG2 rdx
    %define ARG3 r8
    %define ARG4 r9
    %define SHADOW 32
%else
    %define ARG1 rdi
    %define ARG2 rsi
    %define ARG3 rdx
    %define ARG4 rcx
    %define SHADOW 0
%endif

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
%define SDL_WINDOWPOS_UNDEFINED 0x1FFF0000

; SDL event type values
%define SDL_QUIT        0x100
%define SDL_KEYDOWN     0x300

; ============================================================================
; DATA SECTION
; ============================================================================
section .data
    window_title      db  "Readable Assembly - SDL Rectangle Game", 0
    error_init        db  "Failed to initialize SDL: %s", 10, 0
    error_window      db  "Failed to create window: %s", 10, 0
    error_renderer    db  "Failed to create renderer: %s", 10, 0
    msg_init_failed   db  "SDL_Init failed", 0
    msg_window_failed db  "SDL_CreateWindow failed", 0
    msg_renderer_failed db "SDL_CreateRenderer failed", 0

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
    event_storage     resb  64     ; SDL_Event is 56 bytes, keep 64 for safety
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
    push_onto_stack register_rbp
    move    register_rbp, register_rsp

    ; --- Initialize SDL ---
    move    ARG1, SDL_INIT_VIDEO
    sub     register_rsp, SHADOW
    call_procedure SDL_Init
    add     register_rsp, SHADOW
    compare register_rax, 0
    jump_if_less init_failed

    ; --- Create Window ---
    move    ARG1, window_title
    move    ARG2, SDL_WINDOWPOS_UNDEFINED
    move    ARG3, SDL_WINDOWPOS_UNDEFINED
    move    ARG4, WINDOW_WIDTH
%ifidn __OUTPUT_FORMAT__, win64
    ; 5th arg (h) at [rsp+32], 6th arg (flags) at [rsp+40]
    sub     register_rsp, 48
    move    [register_rsp + 32], dword WINDOW_HEIGHT
    move    [register_rsp + 40], dword 0
%else
    move    register_r8d, WINDOW_HEIGHT
    move    register_r9d, 0
%endif
    call_procedure SDL_CreateWindow
%ifidn __OUTPUT_FORMAT__, win64
    add     register_rsp, 48
%endif
    compare register_rax, 0
    jump_if_equal window_failed
    move    [sdl_window], register_rax

    ; --- Create Renderer ---
    move    ARG1, [sdl_window]
    move    ARG2, -1            ; -1 = first driver
    move    ARG3, 0             ; flags
    sub     register_rsp, SHADOW
    call_procedure SDL_CreateRenderer
    add     register_rsp, SHADOW
    compare register_rax, 0
    jump_if_equal renderer_failed
    move    [sdl_renderer], register_rax

    ; --- Get Keyboard State ---
    move    ARG1, 0             ; NULL
    sub     register_rsp, SHADOW
    call_procedure SDL_GetKeyboardState
    add     register_rsp, SHADOW
    move    [keyboard_state], register_rax

    ; ========================================================================
    ; GAME LOOP
    ; ========================================================================
game_loop:
    ; --- Poll for events ---
    move    ARG1, event_storage
    sub     register_rsp, SHADOW
    call_procedure SDL_PollEvent
    add     register_rsp, SHADOW
    compare register_rax, 0
    jump_if_not_equal check_events

    ; --- No events: process keyboard input ---
    call_procedure process_input

    ; --- Clear screen ---
    move    ARG1, [sdl_renderer]
    move    ARG2, BG_RED
    move    ARG3, BG_GREEN
    move    ARG4, BG_BLUE
%ifidn __OUTPUT_FORMAT__, win64
    sub     register_rsp, 48
    move    [register_rsp + 32], dword BG_ALPHA
%else
    move    register_r8d, BG_ALPHA
%endif
    call_procedure SDL_SetRenderDrawColor
%ifidn __OUTPUT_FORMAT__, win64
    add     register_rsp, 48
%endif

    move    ARG1, [sdl_renderer]
    sub     register_rsp, SHADOW
    call_procedure SDL_RenderClear
    add     register_rsp, SHADOW

    ; --- Draw rectangle ---
    call_procedure draw_rectangle

    ; --- Present renderer ---
    move    ARG1, [sdl_renderer]
    sub     register_rsp, SHADOW
    call_procedure SDL_RenderPresent
    add     register_rsp, SHADOW

    ; --- Frame delay (16ms ~ 60fps) ---
    move    ARG1, 16
    sub     register_rsp, SHADOW
    call_procedure SDL_Delay
    add     register_rsp, SHADOW

    ; --- Loop ---
    jump    game_loop

; ============================================================================
; CHECK EVENTS
; ============================================================================
check_events:
    ; Event type is the first 4 bytes of SDL_Event
    move    register_eax, [event_storage]
    compare register_eax, SDL_QUIT
    jump_if_equal cleanup

    compare register_eax, SDL_KEYDOWN
    jump_if_equal check_escape

    jump    game_loop

check_escape:
    ; SDL_KeyboardEvent.keysym.scancode is at offset 16
    move    register_eax, [event_storage + 16]
    compare register_eax, 41            ; SDL_SCANCODE_ESCAPE
    jump_if_equal cleanup
    jump    game_loop

; ============================================================================
; PROCESS INPUT
; ============================================================================
; Reads the keyboard state array (indexed by SDL scancode) and updates the
; rectangle position. No external calls, so no shadow space needed.
; ============================================================================
process_input:
    ; Prologue
    push_onto_stack register_rbp
    move    register_rbp, register_rsp
    push_onto_stack register_rbx

    move    register_rbx, [keyboard_state]

    ; --- Check Up Arrow (scancode 82) ---
    move    register_al, [register_rbx + 82]
    compare register_al, 0
    jump_if_equal check_down
    ; Move up
    move    register_eax, [rect_y]
    subtract register_eax, MOVE_SPEED
    move    [rect_y], register_eax

check_down:
    ; --- Check Down Arrow (scancode 81) ---
    move    register_al, [register_rbx + 81]
    compare register_al, 0
    jump_if_equal check_left
    ; Move down
    move    register_eax, [rect_y]
    add     register_eax, MOVE_SPEED
    move    [rect_y], register_eax

check_left:
    ; --- Check Left Arrow (scancode 80) ---
    move    register_al, [register_rbx + 80]
    compare register_al, 0
    jump_if_equal check_right
    ; Move left
    move    register_eax, [rect_x]
    subtract register_eax, MOVE_SPEED
    move    [rect_x], register_eax

check_right:
    ; --- Check Right Arrow (scancode 79) ---
    move    register_al, [register_rbx + 79]
    compare register_al, 0
    jump_if_equal clamp_position
    ; Move right
    move    register_eax, [rect_x]
    add     register_eax, MOVE_SPEED
    move    [rect_x], register_eax

clamp_position:
    ; --- Clamp X position ---
    move    register_eax, [rect_x]
    compare register_eax, 0
    jump_if_greater_or_equal clamp_x_max
    move    dword [rect_x], 0

clamp_x_max:
    move    register_eax, [rect_x]
    compare register_eax, WINDOW_WIDTH - RECT_SIZE
    jump_if_less_or_equal clamp_y_min
    move    dword [rect_x], WINDOW_WIDTH - RECT_SIZE

clamp_y_min:
    ; --- Clamp Y position ---
    move    register_eax, [rect_y]
    compare register_eax, 0
    jump_if_greater_or_equal clamp_y_max
    move    dword [rect_y], 0

clamp_y_max:
    move    register_eax, [rect_y]
    compare register_eax, WINDOW_HEIGHT - RECT_SIZE
    jump_if_less_or_equal process_done
    move    dword [rect_y], WINDOW_HEIGHT - RECT_SIZE

process_done:
    pop_from_stack register_rbx
    move    register_rsp, register_rbp
    pop_from_stack register_rbp
    return_from_procedure

; ============================================================================
; DRAW RECTANGLE
; ============================================================================
draw_rectangle:
    ; Prologue
    push_onto_stack register_rbp
    move    register_rbp, register_rsp

    ; Copy rect values to rect_storage
    move    register_eax, [rect_x]
    move    [rect_storage], register_eax
    move    register_eax, [rect_y]
    move    [rect_storage + 4], register_eax
    move    register_eax, [rect_w]
    move    [rect_storage + 8], register_eax
    move    register_eax, [rect_h]
    move    [rect_storage + 12], register_eax

    ; Set draw color to rectangle color
    move    ARG1, [sdl_renderer]
    move    ARG2, RECT_RED
    move    ARG3, RECT_GREEN
    move    ARG4, RECT_BLUE
%ifidn __OUTPUT_FORMAT__, win64
    sub     register_rsp, 48
    move    [register_rsp + 32], dword RECT_ALPHA
%else
    move    register_r8d, RECT_ALPHA
%endif
    call_procedure SDL_SetRenderDrawColor
%ifidn __OUTPUT_FORMAT__, win64
    add     register_rsp, 48
%endif

    ; Fill rectangle
    move    ARG1, [sdl_renderer]
    move    ARG2, rect_storage
    sub     register_rsp, SHADOW
    call_procedure SDL_RenderFillRect
    add     register_rsp, SHADOW

    ; Epilogue
    move    register_rsp, register_rbp
    pop_from_stack register_rbp
    return_from_procedure

; ============================================================================
; CLEANUP
; ============================================================================
cleanup:
    ; Destroy renderer
    move    ARG1, [sdl_renderer]
    sub     register_rsp, SHADOW
    call_procedure SDL_DestroyRenderer
    add     register_rsp, SHADOW

    ; Destroy window
    move    ARG1, [sdl_window]
    sub     register_rsp, SHADOW
    call_procedure SDL_DestroyWindow
    add     register_rsp, SHADOW

    ; Quit SDL
    sub     register_rsp, SHADOW
    call_procedure SDL_Quit
    add     register_rsp, SHADOW

    ; Exit with code 0
    move    ARG1, 0
    sub     register_rsp, SHADOW
    call_procedure exit

; ============================================================================
; ERROR HANDLERS
; ============================================================================
init_failed:
    move    ARG1, error_init
    move    ARG2, msg_init_failed
    move    register_al, 0
    sub     register_rsp, SHADOW
    call_procedure printf
    add     register_rsp, SHADOW
    move    ARG1, 1
    sub     register_rsp, SHADOW
    call_procedure exit

window_failed:
    move    ARG1, error_window
    move    ARG2, msg_window_failed
    move    register_al, 0
    sub     register_rsp, SHADOW
    call_procedure printf
    add     register_rsp, SHADOW
    sub     register_rsp, SHADOW
    call_procedure SDL_Quit
    add     register_rsp, SHADOW
    move    ARG1, 1
    sub     register_rsp, SHADOW
    call_procedure exit

renderer_failed:
    move    ARG1, error_renderer
    move    ARG2, msg_renderer_failed
    move    register_al, 0
    sub     register_rsp, SHADOW
    call_procedure printf
    add     register_rsp, SHADOW
    move    ARG1, [sdl_window]
    sub     register_rsp, SHADOW
    call_procedure SDL_DestroyWindow
    add     register_rsp, SHADOW
    sub     register_rsp, SHADOW
    call_procedure SDL_Quit
    add     register_rsp, SHADOW
    move    ARG1, 1
    sub     register_rsp, SHADOW
    call_procedure exit
