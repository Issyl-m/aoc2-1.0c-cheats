# aoc2-1.0c-cheats

Some multi-player cheats that I've coded in the 2012s for the classic game ``Age of Empires II: The Conquerors (ver. 1.0c)``. This package includes a `delete hack` that lets you kill enemy units just by pressing `DEL` and a `map hack` that allows the user to see in the dark zone. The technique used to detour the execution flow in the game was using `hardware breakpoints` to bypass some anti-cheat software.

# Compilation

This project was entirely written in fasm (https://flatassembler.net/). Remember to update the following line in `main.asm` with the corresponding path:

1. `include 'C:\fasmw16726\INCLUDE\win32ax.inc'`.
