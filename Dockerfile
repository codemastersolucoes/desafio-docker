FROM golang:1.14.1-alpine as builder
MAINTAINER "Gilson Gabriel <gilson@codemastersolucoes.com>"

WORKDIR /app

COPY ./src .

RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags "-w -s" -installsuffix cgo -o main ./main

FROM alpine:3.5

RUN rm -rf /var/www/html \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/log/* \
    && rm -rf /var/cache/apk/*

WORKDIR /app

COPY --from=builder /app/main/main .

RUN ./main