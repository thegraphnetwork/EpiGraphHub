#!/usr/bin/env bash

set -ex

POSTFIX_MAIN=/etc/postfix/main.cf

# make a copy
cp "${POSTFIX_MAIN}" "${POSTFIX_MAIN}-$(date --iso-8601)"

cat >> ${POSTFIX_MAIN} <<- POSTFIX
# new changes - 2022-04-08
# ref: https://www.linuxfordevices.com/tutorials/ubuntu/smtp-relay-on-ubuntu
# ref: https://linuxscriptshub.com/configure-smtp-with-gmail-using-postfix/
relayhost = [${SUPERSET_MAIL_SERVER}]:${SUPERSET_MAIL_PORT}
smtp_use_tls = yes
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options =
smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
POSTFIX

POSTFIX_SASL_PASSWD=/etc/postfix/sasl_passwd
# make a copy
cp "${POSTFIX_SASL_PASSWD}" "${POSTFIX_SASL_PASSWD}-$(date --iso-8601)"

cat >> ${POSTFIX_SASL_PASSWD} <<- POSTFIX
[${SUPERSET_MAIL_SERVER}]:${SUPERSET_MAIL_PORT} ${SUPERSET_MAIL_USERNAME}:${SUPERSET_MAIL_PASSWORD}
POSTFIX

postmap ${POSTFIX_SASL_PASSWD}

service postfix restart
