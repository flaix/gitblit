#!/bin/bash
java --add-opens java.base/java.lang=ALL-UNNAMED -cp "gitblit.jar:ext/*" com.gitblit.GitBlitServer --baseFolder data
