; ============================================================================
; SECTION 44: GFNI (GALOIS FIELD) INSTRUCTIONS
; ============================================================================

%macro gfni-affine-transformation 3
    gf2p8affineqb %1, %2, %3
%endmacro

%macro gfni-affine-transformation-inverse 3
    gf2p8affineinvqb %1, %2, %3
%endmacro

%macro gfni-multiply-bytes 2
    gf2p8mulb %1, %2
%endmacro

