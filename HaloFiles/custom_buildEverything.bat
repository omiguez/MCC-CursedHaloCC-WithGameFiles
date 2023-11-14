invader-build.exe -g mcc-cea levels\a10\a10
invader-build.exe -g mcc-cea levels\a30\a30
invader-build.exe -g mcc-cea levels\a50\a50
invader-build.exe -g mcc-cea levels\b30\b30
invader-build.exe -g mcc-cea levels\b40\b40
invader-build.exe -g mcc-cea levels\c10\c10
tool.exe build-cache-file levels\c20\c20 classic none
invader-build.exe -g mcc-cea levels\c40\c40
@REM to compile d20, remove d20_cinema, compile with sapien, put it back, then compile with invader.
invader-build.exe -g mcc-cea levels\d20\d20
invader-build.exe -g mcc-cea levels\d40\d40

@REM these are kart levels, so I'm keeping them commented out for now
@REM invader-build.exe -g mcc-cea levels\c30\c30
@REM invader-build.exe -g mcc-cea levels\c31\c31
@REM invader-build.exe -g mcc-cea levels\c32\c32
@REM invader-build.exe -g mcc-cea levels\c33\c33
@REM invader-build.exe -g mcc-cea levels\c34\c34
@REM invader-build.exe -g mcc-cea levels\c35\c35
@REM invader-build.exe -g mcc-cea levels\c36\c36