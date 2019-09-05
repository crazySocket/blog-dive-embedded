/* Memories definition */
MEMORY
{
    RAM (xrw)     : ORIGIN = 0x20000000, LENGTH = 128K
    CCM (xrw)     : ORIGIN = 0x10000000, LENGTH = 64K
    FLASH (rx)    : ORIGIN = 0x8000000,  LENGTH = 1024K
}

/* Entry Point */
ENTRY(Reset_Handler)

/* Some global symbols useful in code */
__flash_start = ORIGIN(FLASH);
__flash_size  = LENGTH(FLASH);
__flash_end   = __flash_start + __flash_size;

__ram_start = ORIGIN(RAM);
__ram_size  = LENGTH(RAM);
__ram_end   = __ram_start + __ram_size;

__ccm_start = ORIGIN(CCM);
__ccm_size  = LENGTH(CCM);

__stack_size = 16 * 1024;

PROVIDE(__flash_start = __flash_start);
PROVIDE(__flash_size  = __flash_size);
PROVIDE(__flash_end   = __flash_end);

PROVIDE(__ram_start = __ram_start);
PROVIDE(__ram_size  = __ram_size);
PROVIDE(__ram_end   = __ram_end);

PROVIDE(__ccm_start = __ccm_start);
PROVIDE(__ccm_size  = __ccm_size);

/* Sections definitions */
SECTIONS
{
    .isr_vectors :
    {
        . = ALIGN(4);
        KEEP(*(.isr_vectors))
        . = ALIGN(4);
    } > FLASH

    .text :
    {
        . = ALIGN(4);
         __stext = .;
        PROVIDE(__stext = __stext);

        *(.text)
        *(.text*)

        . = ALIGN(4);
        __etext = .;
        PROVIDE(__etext = __etext);
    } > FLASH

    /* Constant data into ROM memory*/
    .rodata :
    {
        . = ALIGN(4);
        *(.rodata)
        *(.rodata*)
        . = ALIGN(4);
    } > FLASH

    .data : 
    {
        . = ALIGN(4);
        __fsdata = LOADADDR (.data);
        PROVIDE(__fsdata = __fsdata);
        __sdata = .;
        PROVIDE(__sdata = __sdata);

        *(.data)
        *(.data*)

        . = ALIGN(4);
        __edata = .;
        PROVIDE(__edata = __edata);
    } > RAM AT > FLASH

    .bss :
    {
        . = ALIGN(4);
        __sbss = .;
        PROVIDE(__sbss = __sbss);
        *(.bss)
        *(.bss*)
        *(COMMON)

        . = ALIGN(4);
        __ebss = .;
        PROVIDE(__ebss = __ebss);
    } > RAM

      /* Stack definition */
    .stack :
    {
        . = ALIGN(8);
        __stack_start = .;
        PROVIDE(__stack_start = __stack_start);
        . = ALIGN(8);
        . += __stack_size;
        . = ALIGN(8);
        __stack_end = .;
        PROVIDE(__stack_end = __stack_end);
    } > RAM

    . = ALIGN(4);
    __heap_start = .;
    PROVIDE(__heap_start = __heap_start);

    . = ALIGN(4);
    __heap_end = __ram_end;
    PROVIDE(__heap_end = __heap_end);

    /* Remove information from the compiler libraries */
    /DISCARD/ :
    {
        libc.a ( * )
        libm.a ( * )
        libgcc.a ( * )
    }

    PROVIDE(__text_size  = __text_end  - __text_start);
    PROVIDE(__data_size  = __data_end  - __data_start);
    PROVIDE(__bss_size   = __bss_end   - __bss_start);
    PROVIDE(__stack_size = __stack_end - __stack_start);
    PROVIDE(__heap_size  = __heap_end  - __heap_start);
}
