FROM rust:latest

# Install Go
RUN curl -OL https://go.dev/dl/go1.21.6.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.21.6.linux-amd64.tar.gz && \
    rm go1.21.6.linux-amd64.tar.gz

ENV PATH=$PATH:/usr/local/go/bin

WORKDIR /app

COPY . .

RUN make build
RUN ./fairyport init

EXPOSE 9090

ENTRYPOINT ["./fairyport"]
CMD ["start", "--config", "$HOME/.fairyroot/config.yml"]
