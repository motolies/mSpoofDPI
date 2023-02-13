FROM golang:1.20 as builder
WORKDIR /src

RUN git clone https://github.com/xvzc/SpoofDPI.git &&  \
    cd SpoofDPI && \
    CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -ldflags='-w -s' github.com/xvzc/SpoofDPI/cmd/spoof-dpi


FROM alpine:latest as app
RUN apk --no-cache add ca-certificates
WORKDIR /app/

COPY --from=builder /src/SpoofDPI/spoof-dpi .

ENV DNS 1.1.1.1
ENV DEBUG false
ENV PORT 8080
EXPOSE $PORT

CMD ["sh", "-c", "./spoof-dpi --addr=0.0.0.0 --dns=$DNS --port=$PORT --debug=$DEBUG"]