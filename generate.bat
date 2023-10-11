@echo off
setlocal enabledelayedexpansion

set /p userid=<userid.txt

del .\output\* /f /q
for /F "usebackq tokens=*" %%l in ("prompts.txt") do (
	set prompt=%%l

	echo.
	echo Executing prompt: !prompt!

	python -m BingImageCreator -U "!userid!" --prompt "!prompt!" --output-dir .\output

	set prompt=!prompt: =_!
	set prompt=!prompt:.=_!
	set prompt=!prompt:,=_!
	set prompt=!prompt:;=_!

	for %%f in (.\output\*) do (
		FOR /f "tokens=*" %%g IN ('.\uuid.bat') do (set uuid=%%g)
		move "%%f" ".\images\!prompt!_!uuid!.jpg" > nul 2> nul
	)
)