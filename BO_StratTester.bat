@echo off
if exist bin (
	goto launch )
cd ..
if exist bin (
	goto launch )
cd ..
if exist bin (
	goto launch )
goto error

:launch
cd bin
if exist launcher_ldr.exe (
	goto run )
:error
echo Could not find launcher_ldr.exe
pause
exit

:run
start launcher_ldr.exe game_mod.dll ../BlackOps.exe +set fs_game "mods/Strat Tester"