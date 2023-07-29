.syntax unified
.thumb
.arch armv6-m

.text
Configure_Portcon:
.global Configure_Portcon
.type Configure_Portcon, STT_FUNC
    ldr        r0,ADDR_PORTA_SEL0
    ldr        r0,[r0,#0x0]
    ldr        r1,PORTA_SEL0_AND_MASK
    ands       r0,r1
    ldr        r1,ADDR_PORTA_SEL0
    str        r0,[r1,#0x0]
    mov        r0,r1
    ldr        r0,[r0,#0x0]
    movs       r1,#0x1
    lsls       r1,r1,#0x1c
    orrs       r0,r1
    ldr        r1,ADDR_PORTA_SEL0
    str        r0,[r1,#0x0]
    mov        r0,r1
    ldr        r0,[r0,#0x4]         //offset PORTA_SEL1
    ldr        r1,PORTA_SEL1_AND_MASK
    ands       r0,r1
    ldr        r1,ADDR_PORTA_SEL0
    str        r0,[r1,#0x4]      //#offset PORTA_SEL1]
    mov        r0,r1
    ldr        r0,[r0,#0x4]         //#offset PORTA_SEL1]
    ldr        r1,PORTA_SEL1_OR_MASK
    orrs       r0,r1
    ldr        r1,ADDR_PORTA_SEL0
    str        r0,[r1,#0x4]
    mov        r0,r1
    ldr        r0,[r0,#0x8]
    lsls       r0,r0,#0x8
    lsrs       r0,r0,#0x8
    str        r0,[r1,#0x8]
    mov        r0,r1
    ldr        r0,[r0,#0x8]
    movs       r1,#0x1
    lsls       r1,r1,#0x1c
    orrs       r0,r1
    ldr        r1,ADDR_PORTA_SEL0
    str        r0,[r1,#0x8]
    mov        r0,r1
    ldr        r0,[r0,#0xc]
    ldr        r1,PORTB_SEL1_AND_MASK
    ands       r0,r1
    ldr        r1,ADDR_PORTA_SEL0
    str        r0,[r1,#0xc]
    mov        r0,r1
    ldr        r0,[r0,#0xc]
    movs       r1,#0xff
    adds       r1,#0x2
    orrs       r0,r1
    ldr        r1,ADDR_PORTA_SEL0
    str        r0,[r1,#0xc]
    mov        r0,r1
    ldr        r0,[r0,#0x10]
    lsrs       r0,r0,#0x18
    lsls       r0,r0,#0x18
    str        r0,[r1,#0x10]
    ldr        r0,ADDR_PORTA_IE
    ldr        r0,[r0,#0x0]
    movs       r1,#0xff
    adds       r1,#0x79
    orrs       r0,r1
    ldr        r1,ADDR_PORTA_IE
    str        r0,[r1,#0x0]
    mov        r0,r1
    ldr        r0,[r0,#0x0]
    movs       r1,#0xf
    lsls       r1,r1,#0xa
    bics       r0,r1
    ldr        r1,ADDR_PORTA_IE
    str        r0,[r1,#0x0]
    ldr        r0,ADDR_PORTA_PU
    ldr        r0,[r0,#0x0]
    movs       r1,#0x78
    orrs       r0,r1
    ldr        r1,ADDR_PORTA_PU
    str        r0,[r1,#0x0]
    mov        r0,r1
    ldr        r0,[r0,#0x0]
    movs       r1,#0xf
    lsls       r1,r1,#0xa
    bics       r0,r1
    ldr        r1,ADDR_PORTA_PU
    str        r0,[r1,#0x0]
    ldr        r0,ADDR_PORTA_PD
    ldr        r0,[r0,#0x0]
    ldr        r1,PORTA_PD_AND_MASK
    ands       r0,r1
    ldr        r1,ADDR_PORTA_PD
    str        r0,[r1,#0x0]
    ldr        r0,ADDR_PORTA_OD
    ldr        r0,[r0,#0x0]
    movs       r1,#0x78
    orrs       r0,r1
    ldr        r1,ADDR_PORTA_OD
    str        r0,[r1,#0x0]
    mov        r0,r1
    ldr        r0,[r0,#0x0]
    movs       r1,#0xf
    lsls       r1,r1,#0xa
    bics       r0,r1
    ldr        r1,ADDR_PORTA_OD
    str        r0,[r1,#0x0]
    ldr        r0,ADDR_PORTA_IE
    ldr        r0,[r0,#0x4]
    movs       r1,#0x1
    lsls       r1,r1,#0xe
    orrs       r0,r1
    ldr        r1,ADDR_PORTA_IE
    str        r0,[r1,#0x4]
    mov        r0,r1
    ldr        r0,[r0,#0x4]
    ldr        r1,PORTB_IE_AND_MASK
    ands       r0,r1
    ldr        r1,ADDR_PORTA_IE
    str        r0,[r1,#0x4]
    ldr        r0,ADDR_PORTA_PU
    ldr        r0,[r0,#0x4]
    ldr        r1,PORTB_PU_PD_AND_MASK
    ands       r0,r1
    ldr        r1,ADDR_PORTA_PU
    str        r0,[r1,#0x4]
    ldr        r0,ADDR_PORTA_PD
    ldr        r0,[r0,#0x4]
    ldr        r1,PORTB_PU_PD_AND_MASK
    ands       r0,r1
    ldr        r1,ADDR_PORTA_PD
    str        r0,[r1,#0x4]
    ldr        r0,ADDR_PORTA_OD
    ldr        r0,[r0,#0x4]
    ldr        r1,PORTB_OD_AND_MASK
    ands       r0,r1
    ldr        r1,ADDR_PORTA_OD
    str        r0,[r1,#0x4]
    mov        r0,r1
    ldr        r0,[r0,#0x4]
    movs       r1,#0x1
    lsls       r1,r1,#0xe
    orrs       r0,r1
    ldr        r1,ADDR_PORTA_OD
    str        r0,[r1,#0x4]
    ldr        r0,ADDR_PORTA_IE
    ldr        r0,[r0,#0x8]
    movs       r1,#0x20
    orrs       r0,r1
    ldr        r1,ADDR_PORTA_IE
    str        r0,[r1,#0x8]
    mov        r0,r1
    ldr        r0,[r0,#0x8]
    lsrs       r0,r0,#0x5
    lsls       r0,r0,#0x5
    str        r0,[r1,#0x8]
    ldr        r0,ADDR_PORTA_PU
    ldr        r0,[r0,#0x8]
    movs       r1,#0x20
    orrs       r0,r1
    ldr        r1,ADDR_PORTA_PU
    str        r0,[r1,#0x8]
    mov        r0,r1
    ldr        r0,[r0,#0x8]
    lsrs       r0,r0,#0x5
    lsls       r0,r0,#0x5
    str        r0,[r1,#0x8]
    ldr        r0,ADDR_PORTA_PD
    ldr        r0,[r0,#0x8]
    lsrs       r0,r0,#0x6
    lsls       r0,r0,#0x6
    ldr        r1,ADDR_PORTA_PD
    str        r0,[r1,#0x8]
    ldr        r0,ADDR_PORTA_OD
    ldr        r0,[r0,#0x8]
    lsrs       r0,r0,#0x5
    lsls       r0,r0,#0x5
    ldr        r1,ADDR_PORTA_OD
    str        r0,[r1,#0x8]
    mov        r0,r1
    ldr        r0,[r0,#0x8]
    movs       r1,#0x20
    orrs       r0,r1
    ldr        r1,ADDR_PORTA_OD
    str        r0,[r1,#0x8]
    bx         lr
    ADDR_PORTA_SEL0:        .word   0x400B0000
    PORTA_SEL0_AND_MASK:    .word   0xF0000FFF
    PORTA_SEL1_AND_MASK:    .word   0xFF0000FF
    PORTA_SEL1_OR_MASK:     .word   0x05000051
    PORTB_SEL1_AND_MASK:    .word   0x00FF0F0F
    ADDR_PORTA_IE:          .word   0x400B0100
    ADDR_PORTA_PU:          .word   0x400B0200
    ADDR_PORTA_PD:          .word   0x400B0300
    PORTA_PD_AND_MASK:      .word   0xFFFFC387
    ADDR_PORTA_OD:          .word   0x400B0400
    PORTB_IE_AND_MASK:      .word   0xFFFF703F
    PORTB_PU_PD_AND_MASK:   .word   0xFFFF35BF
    PORTB_OD_AND_MASK:      .word   0xFFFF75BF
