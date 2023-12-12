FROM nginx:1.23-alpine

RUN apk add --no-cache curl bash openssl

COPY ./nginx/conf.d /etc/nginx/conf.d
COPY ./nginx/snippets /etc/nginx/snippets
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
WORKDIR /var/www

RUN mkdir /etc/nginx/ssl; cd /etc/nginx/ssl/; openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout bitrix-dev.local.key -out bitrix-dev.local.crt \
    -subj "/C=US/ST=State/L=City/O=Organization/OU=Department/CN=bitrix-dev.local"

# Copy the self-signed certificate to the container
#COPY /etc/nginx/ssl/bitrix-dev.local.crt /usr/local/share/ca-certificates/

# Install the certificate in the container's certificate store
#RUN update-ca-certificates
#RUN certutil -d sql:$HOME/.pki/nssdb -A -t "CT,c,c" -n "localhost" -i localhost.crt
