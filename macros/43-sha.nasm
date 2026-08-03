; ============================================================================
; SECTION 43: SHA INSTRUCTIONS
; ============================================================================

%macro sha_message_schedule_1 2
    sha1msg1 %1, %2
%endmacro

%macro sha_message_schedule_2 2
    sha1msg2 %1, %2
%endmacro

%macro sha_next_round 2
    sha1nexte %1, %2
%endmacro

%macro sha_round_1 3
    sha1rnds4 %1, %2, %3
%endmacro

%macro sha_message_schedule_256_1 2
    sha256msg1 %1, %2
%endmacro

%macro sha_message_schedule_256_2 2
    sha256msg2 %1, %2
%endmacro

%macro sha_round_256 3
    sha256rnds2 %1, %2, %3
%endmacro

