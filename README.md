# stm32-blinky-asm-60 #

Example minimalistic led blinky for STM32 (tested on Black Pill dev board) written in assembly, with Docker-based GNU ARM EABI build.

60 bytes.

Can be used as a template for projects. I am a fan of open source software and non-interactive builds to integrate into CI/CD pipelines, hence my belief that modern embedded builds must be containerized.

## Dependencies ##
You do not need anything except Docker to build, and st-link to upload firmware to microcontroller.

## Build ##
Checked it with Black Pill, most likely you will need to adjust constants in main.s and linker script to fit your MC and pinout. All the numbers are available in documentation from ARM - see comments in the code.

Build in Docker container:

`./build.sh`

Flash with st-link:

`./flash.sh`


## Links ##
Inspired by https://habr.com/ru/articles/274579/ (in Russian)
