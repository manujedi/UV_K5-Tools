.syntax unified
.thumb
.arch armv6-m

.text
SETUP_WRAPPER:
.global SETUP_WRAPPER
.type SETUP_WRAPPER, STT_FUNC
    push    {r4, lr}
    bl      Configure_Portcon   //this will become the portcon
    bl      FUN_0000b05c
    bl      FUN_00009dbc
    bl      FUN_0000b768
    movs    r1,#0x0
    mov     r0,r1
    bl      FUN_0000b2a8
    bl      FUN_0000a1ac
    pop     {r4,pc}
