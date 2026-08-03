; ============================================================================
; SECTION 44: GFNI (GALOIS FIELD) INSTRUCTIONS
; ============================================================================

%macro gfni_affine_transformation 3
    gf2p8affineqb %1, %2, %3
%endmacro

%macro gfni_affine_transformation_inverse 3
    gf2p8affineinvqb %1, %2, %3
%endmacro

%macro gfni_multiply_bytes 2
    gf2p8mulb %1, %2
%endmacro

