FROM quay.io/projectquay/golang:1.20 AS builder

WORKDIR /go/src/app
COPY . .
RUN make build

# hide 'FROM' for hotfix/prometheus.org_test-3.5.5
#FROM alpine:latest
# unhide 'FROM' for hotfix/prometheus.org_test-3.5.5
FROM scratch
WORKDIR /app
# hide 'COPY' for hotfix/prometheus.org_test-3.5.5
# COPY .env /app
COPY --from=builder /go/src/app/kbot .
# hide 'COPY' for hotfix/prometheus.org_test-3.5.5
#COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs
ENTRYPOINT ["./kbot", "start"]