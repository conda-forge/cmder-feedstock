xcopy cmder %PREFIX%\cmder /e /i /y /s
if errorlevel 1 exit 1

IF NOT EXIST %PREFIX%\Menu mkdir %PREFIX%\Menu
if errorlevel 1 exit 1

copy %RECIPE_DIR%\menu-windows.json %PREFIX%\Menu\
if errorlevel 1 exit 1

rem cmder vendors a full Git for Windows release, which bundles its own
rem frozen CA trust store. Drop the duplicate-format artifacts nothing in
rem the bundled tools reads, and refresh the live OpenSSL/curl bundle
rem paths from conda-forge's ca-certificates package so the embedded copy
rem isn't frozen at cmder's release date.
set GFW=%PREFIX%\cmder\vendor\git-for-windows
set CACERT=%LIBRARY_PREFIX%\ssl\cacert.pem

rmdir /s /q "%GFW%\etc\pki\ca-trust\extracted"
if errorlevel 1 exit 1
rmdir /s /q "%GFW%\mingw64\etc\pki\ca-trust\extracted"
if errorlevel 1 exit 1
del /q "%GFW%\usr\share\pki\ca-trust-source\ca-bundle.trust.crt"
if errorlevel 1 exit 1
del /q "%GFW%\mingw64\share\pki\ca-trust-source\ca-bundle.trust.crt"
if errorlevel 1 exit 1

copy /y "%CACERT%" "%GFW%\usr\ssl\cert.pem"
if errorlevel 1 exit 1
copy /y "%CACERT%" "%GFW%\usr\ssl\certs\ca-bundle.crt"
if errorlevel 1 exit 1
copy /y "%CACERT%" "%GFW%\usr\ssl\certs\ca-bundle.trust.crt"
if errorlevel 1 exit 1
copy /y "%CACERT%" "%GFW%\mingw64\ssl\cert.pem"
if errorlevel 1 exit 1
copy /y "%CACERT%" "%GFW%\mingw64\ssl\certs\ca-bundle.crt"
if errorlevel 1 exit 1
copy /y "%CACERT%" "%GFW%\mingw64\ssl\certs\ca-bundle.trust.crt"
if errorlevel 1 exit 1

rem Re-resolve the CA bundle from whatever ca-certificates is installed on
rem every shell activation, instead of relying solely on the snapshot
rem copied in above at build time.
IF NOT EXIST %PREFIX%\etc\conda\activate.d mkdir %PREFIX%\etc\conda\activate.d
if errorlevel 1 exit 1
IF NOT EXIST %PREFIX%\etc\conda\deactivate.d mkdir %PREFIX%\etc\conda\deactivate.d
if errorlevel 1 exit 1
copy %RECIPE_DIR%\activate.bat %PREFIX%\etc\conda\activate.d\cmder-activate.bat
if errorlevel 1 exit 1
copy %RECIPE_DIR%\deactivate.bat %PREFIX%\etc\conda\deactivate.d\cmder-deactivate.bat
if errorlevel 1 exit 1

exit 0
