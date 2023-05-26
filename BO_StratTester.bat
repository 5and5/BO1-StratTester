@echo off
if exist bin (
	goto launch )
cd ..
if exist bin (
	goto launch )
cd ..
if exist bin (
	goto launch )
echo Could not find launcher_ldr.exe
pause
exit

:launch
cd bin
start launcher_ldr.exe game_mod.dll ../BlackOps.exe +set fs_game "mods/Strat Tester"