@echo off

if defined _CMDER_OLD_GIT_SSL_CAINFO (
    set "GIT_SSL_CAINFO=%_CMDER_OLD_GIT_SSL_CAINFO%"
    set "_CMDER_OLD_GIT_SSL_CAINFO="
) else (
    set "GIT_SSL_CAINFO="
)

if defined _CMDER_OLD_CURL_CA_BUNDLE (
    set "CURL_CA_BUNDLE=%_CMDER_OLD_CURL_CA_BUNDLE%"
    set "_CMDER_OLD_CURL_CA_BUNDLE="
) else (
    set "CURL_CA_BUNDLE="
)

if defined _CMDER_OLD_SSL_CERT_FILE (
    set "SSL_CERT_FILE=%_CMDER_OLD_SSL_CERT_FILE%"
    set "_CMDER_OLD_SSL_CERT_FILE="
) else (
    set "SSL_CERT_FILE="
)
