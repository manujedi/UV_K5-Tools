__orig_fw = 0x0;
FUN_0000b05c = 0xb05c;
FUN_00009dbc = 0x9dbc;
FUN_0000b768 = 0xb768;
FUN_0000b2a8 = 0xb2a8;
FUN_0000a1ac = 0xa1ac;
FUN_0000afe0 = 0xafe0;

ENTRY(Reset_Handler)

MEMORY
{
    RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 2K
    FLASH (rx)  : ORIGIN = 0x00000000, LENGTH = 60K
}

_estack = 0x200020000;


SECTIONS
{
    . = 0x0;
    .isr_vectors :
    {
     . = ALIGN(4);
     KEEP(*(.isr_vectors))
     . = ALIGN(4);
    } >FLASH

    .org_fw_rest :
    {
      . = ALIGN(4);
      KEEP(*(.org_fw_rest))
    } > FLASH
    .text :
    {
        . = ALIGN(4);
        *(.text)
        *(.text*)
        *(.rodata)
        *(.rodata*)
        KEEP (*(.init))
        KEEP (*(.fini))
        . = ALIGN(4);
    } >FLASH

    .preinit_array     :
    {
      __preinit_array_start = .;
      KEEP (*(.preinit_array*))
      __preinit_array_end = .;
    } >FLASH
    .init_array :
    {
      __init_array_start = .;
      KEEP (*(SORT(.init_array.*)))
      KEEP (*(.init_array*))
      __init_array_end = .;
    } >FLASH
    .fini_array :
    {
      PROVIDE_HIDDEN (__fini_array_start = .);
      KEEP (*(SORT(.fini_array.*)))
      KEEP (*(.fini_array*))
      PROVIDE_HIDDEN (__fini_array_end = .);
      . = ALIGN(4);
      _flash_data_start = .;
    } >FLASH

     _sidata = LOADADDR(.data);
    .data : AT (_flash_data_start)
    {
        . = ALIGN(4);
        _sdata = .;
        *(.data)
        *(.data*)
        *(.ramsection)
        _edata = .;
    } >RAM

    .bss :
    {
      . = ALIGN(4);
       _sbss = .;
        *(.bss)
      _ebss = .;
    } >RAM

}