FROM golang:1.12.5-alpine3.9 as build
EXPOSE 1313
RUN mkdir -p /wd/content /wd/archetypes
RUN apk update && \
    apk upgrade && \
    apk add --no-cache libc6-compat libstdc++
RUN wget https://github.com/gohugoio/hugo/releases/download/v0.55.6/hugo_extended_0.55.6_Linux-64bit.tar.gz -O hugo.tar.gz && \
    tar -xzvf hugo.tar.gz && \
    cp hugo /usr/local/bin
WORKDIR /wd
CMD [ "hugo" ]
ENTRYPOINT [ ]
COPY . /wd
RUN hugo

# FROM nginxinc/nginx-unprivileged:1.17-alpine
FROM nginxinc/nginx-unprivileged:latest
USER root
RUN adduser -S -D -u 101 -h /var/cache/nginx -s /sbin/nologin -G nginx -g nginx nginx \
    && chown -R 101:0 /var/cache/nginx \
    && chmod -R g+w /var/cache/nginx
USER 101
COPY --from=build --chown=101 /wd/public /usr/share/nginx/html
CMD ["nginx","-g","daemon off;"]
