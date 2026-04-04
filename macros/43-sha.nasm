; ============================================================================
; SECTION 43: SHA INSTRUCTIONS
; ============================================================================

%macro sha-message-schedule-1 2
    sha1msg1 %1, %2
%endmacro

%macro sha-message-schedule-2 2
    sha1msg2 %1, %2
%endmacro

%macro sha-next-round 2
    sha1nexte %1, %2
%endmacro

%macro sha-round-1 3
    sha1rnds4 %1, %2, %3
%endmacro

%macro sha-message-schedule-256-1 2
    sha256msg1 %1, %2
%endmacro

%macro sha-message-schedule-256-2 2
    sha256msg2 %1, %2
%endmacro

%macro sha-round-256 3
    sha256rnds2 %1, %2, %3
%endmacro

