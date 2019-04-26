FROM nginx:alpine

RUN apk update && \ 
    apk add python3 \
    && rm -rf /var/cache/apk/*

WORKDIR /app
COPY --from=vouch-proxy:latest /vouch-proxy .
COPY --from=vouch-proxy:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=vouch-proxy:latest /templates templates
COPY --from=vouch-proxy:latest /static static
COPY nginx.conf vouch_proxy_config.yml entrypoint.sh update.py ./

CMD [ "./entrypoint.sh" ]
