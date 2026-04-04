; ============================================================================
; SECTION 21: CACHE AND MEMORY MANAGEMENT
; ============================================================================

%macro flush-cache-line 1
    clflush %1
%endmacro

%macro flush-cache-line-optimized 1
    clflushopt %1
%endmacro

%macro cache-line-write-back 1
    clwb %1
%endmacro

%macro cache-line-demote 1
    cldemote %1
%endmacro

%macro load-fence 0
    lfence
%endmacro

%macro store-fence 0
    sfence
%endmacro

%macro memory-fence 0
    mfence
%endmacro

%macro prefetch-t0 1
    prefetcht0 %1
%endmacro

%macro prefetch-t1 1
    prefetcht1 %1
%endmacro

%macro prefetch-t2 1
    prefetcht2 %1
%endmacro

%macro prefetch-nta 1
    prefetchnta %1
%endmacro

%macro prefetch-write 1
    prefetchw %1
%endmacro

