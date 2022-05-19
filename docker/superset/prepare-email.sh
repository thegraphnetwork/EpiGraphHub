#!/usr/bin/env bash

set -ex

# POSTFIX_MAIN=/etc/postfix/main.cf
POSTFIX_MAIN=/tmp/log.txt
GMAIL_PATTERN="relayhost = [smtp.gmail.com]:587"
grep "$GMAIL_PATTERN" $POSTFIX_MAIN

cat >> $POSTFIX_MAIN <<- POSTFIX
# new changes - 2022-04-08
# ref: https://app.mailjet.com/auth/get_started/developer
# ref: https://www.linuxfordevices.com/tutorials/ubuntu/smtp-relay-on-ubuntu
# ref: https://linuxscriptshub.com/configure-smtp-with-gmail-using-postfix/
relayhost = [smtp.gmail.com]:587
smtp_use_tls = yes
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options =
smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
POSTFIX

cat /etc/postfix/sasl_passwd


# POSTFIX_MAIN=/etc/postfix/main.cf
