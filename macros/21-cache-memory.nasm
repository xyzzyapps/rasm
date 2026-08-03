; ============================================================================
; SECTION 21: CACHE AND MEMORY MANAGEMENT
; ============================================================================

%macro flush_cache_line 1
    clflush %1
%endmacro

%macro flush_cache_line_optimized 1
    clflushopt %1
%endmacro

%macro cache_line_write_back 1
    clwb %1
%endmacro

%macro cache_line_demote 1
    cldemote %1
%endmacro

%macro load_fence 0
    lfence
%endmacro

%macro store_fence 0
    sfence
%endmacro

%macro memory_fence 0
    mfence
%endmacro

%macro prefetch_t0 1
    prefetcht0 %1
%endmacro

%macro prefetch_t1 1
    prefetcht1 %1
%endmacro

%macro prefetch_t2 1
    prefetcht2 %1
%endmacro

%macro prefetch_nta 1
    prefetchnta %1
%endmacro

%macro prefetch_write 1
    prefetchw %1
%endmacro

