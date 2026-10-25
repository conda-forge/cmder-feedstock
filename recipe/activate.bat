@echo off

rem Point cmder's bundled git/curl/openssl at the env's CA bundle instead
rem of the frozen copy vendored inside cmder\vendor\git-for-windows.
if defined GIT_SSL_CAINFO set "_CMDER_OLD_GIT_SSL_CAINFO=%GIT_SSL_CAINFO%"
if defined CURL_CA_BUNDLE set "_CMDER_OLD_CURL_CA_BUNDLE=%CURL_CA_BUNDLE%"
if defined SSL_CERT_FILE set "_CMDER_OLD_SSL_CERT_FILE=%SSL_CERT_FILE%"

set "GIT_SSL_CAINFO=%CONDA_PREFIX%\Library\ssl\cacert.pem"
set "CURL_CA_BUNDLE=%CONDA_PREFIX%\Library\ssl\cacert.pem"
set "SSL_CERT_FILE=%CONDA_PREFIX%\Library\ssl\cacert.pem"
