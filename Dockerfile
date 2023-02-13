FROM golang:1.20 as builder

WORKDIR /src

RUN git clone https://github.com/xvzc/SpoofDPI.git &&  \
    cd SpoofDPI && \
    go build -ldflags='-w -s' github.com/xvzc/SpoofDPI/cmd/spoof-dpi && \
    cp spoof-dpi /src && \
    cd /src && \
    rm -rf /src/SpoofDPI

CMD [ "./spoof-dpi", "--addr=0.0.0.0", "--dns=1.1.1.1", "--port=8080", "--debug=true"]
