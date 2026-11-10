; ============================================================================
; 04-segments.nasm - Segment Overrides
; ============================================================================

; Colon form for a segment override: code_segment_override[rax] -> cs:[rax]
; The register itself is code_segment, defined in 01-registers.nasm.
%define code_segment_override   cs:
%define data_segment_override   ds:
%define extra_segment_override  es:
%define fs_segment_override     fs:
%define gs_segment_override     gs:
%define stack_segment_override  ss:
%define segment_cs          cs:
%define segment_ds          ds:
%define segment_es          es:
%define segment_fs          fs:
%define segment_gs          gs:
%define segment_ss          ss:
