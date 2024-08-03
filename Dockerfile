FROM quay.io/projectquay/golang:1.20 AS builder

WORKDIR /go/src/app
COPY . .
RUN make build

FROM alpine:latest
WORKDIR /app
COPY .env /app
COPY --from=builder /go/src/app/kbot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs
ENTRYPOINT ["./kbot", "start"]