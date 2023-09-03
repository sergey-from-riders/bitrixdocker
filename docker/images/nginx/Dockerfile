FROM nginx:1.19-alpine

RUN apk add --no-cache curl bash

COPY ./nginx/conf.d /etc/nginx/conf.d
COPY ./nginx/snippets /etc/nginx/snippets
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
WORKDIR /var/www
