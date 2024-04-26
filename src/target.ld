/* Linker script */
/* This is for STM32F401CCU, including Black Pill, and need to be adjusted for other MCs */

MEMORY
{
    /* Origin is same for probably all STM32s, but size of flash memory is different */
    FLASH(RX) : ORIGIN = 0x08000000, LENGTH = 256K
}

SECTIONS
{
    /* Text section of the source goes to flash memory */
    .text : {
        *(.text);
    } > FLASH
}