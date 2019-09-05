OUTPUT_FORMAT("elf64-x86-64", "elf64-x86-64", "elf64-x86-64")
ENTRY(_start)
SECTIONS
{
  /* Read-only sections, merged into text segment: */
  . = 0x400000;
  .text : { *(.text) }
  .rela.dyn       :
  {
    *(.rela.dyn)
  }
  .rela.plt       :
  {
    *(.rela.plt)
  }
  .init           :
  {
    KEEP (*(SORT_NONE(.init)))
  }
  .init_array     :
  {
    PROVIDE_HIDDEN (__init_array_start = .);
    PROVIDE_HIDDEN (__init_array_end = .);
  }
  /* Remove information from the compiler libraries */
  /DISCARD/ :
  {
    libc.a ( * )
  }
}
