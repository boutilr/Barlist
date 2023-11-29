cd %ARPDIR%\Barlist\Documentation

rmdir /S /Q doc
doxygen Doxygen.dox

rem ** The code below replaces Doxygen's search.js file with version from https://github.com/divideconcept/DoxygenDeepSearch
rem    into our html help system to enable plain text search on both browser and server.
copy /Y %ARPDIR%\WBFL\DoxygenDeepSearch\search.js doc\html\search\search.js

rem ** Use of the deep search search.js requires modification of the search.html generated by Doxygen
rem    search xml data is appended as a script to the end of the file
set SEARCH_HTML=doc\html\search.html  
echo ^<script id="searchdata" type="text/xmldata"^> >> %SEARCH_HTML%
type doc\searchdata.xml >> %SEARCH_HTML%
echo ^</script^> >> %SEARCH_HTML%

%ARPDIR%\BridgeLink\RegFreeCOM\x64\Release\MakeDocMap Barlist
rmdir /S /Q %ARPDIR%\BridgeLink\Docs\Barlist\%1\
mkdir %ARPDIR%\BridgeLink\Docs\Barlist\%1\
xcopy /s /y /d %ARPDIR%\Barlist\Documentation\doc\html\* %ARPDIR%\BridgeLink\Docs\Barlist\%1\
copy %ARPDIR%\Barlist\Documentation\Barlist.dm %ARPDIR%\BridgeLink\Docs\Barlist\%1\
