@SETLOCAL

@SET gbhome=%~dp0
@SET gbhome=%gbhome:~0,-1%

@java --add-opens java.base/java.lang=ALL-UNNAMED -cp "%gbhome%\gitblit.jar";"%gbhome%\ext\*" com.gitblit.GitBlitServer --baseFolder "%gbhome%\data" %*

@ENDLOCAL
