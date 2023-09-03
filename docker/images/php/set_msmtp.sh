#!/bin/bash

cat << EOF > /etc/msmtprc
# smtp account configuration for default
account default
logfile /var/log/msmtp/default.log

host ${MAIL_HOST}
port ${MAIL_PORT}
from ${MAIL_FROM}
user ${MAIL_USER}
password ${MAIL_PASSWORD}

keepbcc on
auth on

tls on
tls_starttls on
tls_certcheck off
EOF

chmod 600 /etc/msmtprc

cat << EOF > /var/www/.msmtprc
# smtp account configuration for default
account default
logfile /var/log/msmtp/default.log

host ${MAIL_HOST}
port ${MAIL_PORT}
from ${MAIL_FROM}
user ${MAIL_USER}
password ${MAIL_PASSWORD}

keepbcc on
auth on

tls on
tls_starttls on
tls_certcheck off
EOF

chmod 600 /var/www/.msmtprc
chown www-data:www-data /var/www/.msmtprc
