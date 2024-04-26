@ These instructions needed to set up assembler. We use thumb instruction set and specify core
.syntax unified
.thumb
.cpu cortex-m4

@ ARM periphery is programmed by writing to specific addresses of memory. You will need STM32 Reference Manual to find them.
@ RCC register is used to enable periphery that is switched off by default to save power
.equ RCC, 0x40023800
@ within RCC, there is an AHB1ENR register that is used to switch on/off GPIOs. We will need it
.equ AHB1ENR, 0x30

@ on Black Pill, LED is PC13, C stands for GPIOC (there also GPIOA, GPIOB etc collectively GPIOx)
@ Settings for GPIOC are at this memory location
.equ GPIOC, 0x40020800
@ GPIO mode register address (relative to GPIOx) to designate pins as inputs or outputs
.equ GPIOx_MODER, 0x00
@ GPIO data register (relative to GPIOx) specified whether pins are high or low
.equ GPIOx_DATA, 0x14

@ Linker will put this to 0x0800000 according to linker script, this is the start of our program
@ first two words (4 bytes) are reserved as described below, we put specific values here
.section .text

@ this word is stack pointer, it is address of the last byte of SRAM + 1. Need to be adjusted to your MC
.word   0x20010000
@ This is entry point. We need to add 1 to entry point address to enable Thumb instruction set.
.word   EntryPoint+1

EntryPoint:

    @ enable AHB1 by setting bit 2 (zero based) to 1
    LDR R1, =(RCC + AHB1ENR)
    LDR R0, [R1]
    ORR R0, 0x4
    STR R0, [R1]

    @ set PC13 to output by setting bit number 26 to high
    LDR R1, =(GPIOC + GPIOx_MODER)
    LDR R0, [R1]
    ORR R0, #0x4000000
    STR R0, [R1]

    @ we will need this address in cycle, it is address of the data
    @ the following instruction is 4 bytes shorter than LDR R1, =(GPIOC + GPIOx_DATA)
    ADD R1, (GPIOx_DATA - GPIOx_MODER)

MainLoop:

    @ invert bit 13 (zero based) in GPIOC_DATA (responsible for pin PC13)
    LDR R0, [R1]
    EOR R0, R0, #0x2000
    STR R0, [R1]

    @ load a large number into R2 and decrement it in a loop to waste some time
    LDR R2, =0x100000

DelayLoop:
    SUBS R2, R2, 1
    BNE DelayLoop

    B MainLoop
