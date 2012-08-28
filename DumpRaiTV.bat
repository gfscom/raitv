@echo off
cls
COLOR A

echo RaiTV Batch Dump
echo.Codice originale: @gialloporpora
echo.Modifiche: @gioxx
echo.Revisione: 20120821-1500
echo;

set url=%1
IF [%1]==[] goto NOURL
set UA=" Mozilla/5.0 (Windows NT 5.1; rv:12.0a1) Gecko/20120130 Firefox/12.0"
wget -q  -U %ua%  %url% -O temp.html
sed  -i -n  -e "/mediapolis/{s/.*"""\(http.*mediapolis.*\)""".*/\1/; p; q}" temp.html

for /f %%i in (temp.html) do set url=%%i
echo URL VIDEO: %url%
wget -q  -U %ua% %url% -O temp.html
sed -i -n -e "s/.*href="""http:\/\/\(.*\)""".*/mmsh:\/\/\1/I; s/ /%%20/g; p" temp.html
for /f %%i in (temp.html) do set url=%%i
echo URL STREAM: %url%
echo;
pause

mplayer %url% -dumpstream -user-agent %ua%
REM for /f "delims=. tokens=1,2,3" %%i in ("%time%") do set mytime=%%i%%j
REM ren stream.dump myfile%mytime%.wmv
set GIORNO=%DATE:~0,2%
set MESE=%DATE:~3,2%
set ANNO=%DATE:~6,4%
ren stream.dump myfile_%ANNO%%MESE%%GIORNO%.wmv
goto fine

:NOURL
cls
color C
echo ATTENZIONE
echo Occorre lanciare il programma includendo l'URL della pagina web contenente il video
echo.esempio: DumpRaiTV.bat http://www.rai.tv/dl/RaiTV/programmi/media/ContentItem-17b2afa7-d834-45aa-b1dc-4a64c60ee936.html#p=
echo;
:FINE