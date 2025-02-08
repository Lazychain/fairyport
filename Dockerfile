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

ARG CHAIN_RPC
ARG CONTRACT_ADDRESS
RUN sed -i "s|chainrpc: .*|chainrpc: ${CHAIN_RPC}|g" $HOME/.fairyport/config.yml && \
    sed -i "s|contractaddress: .*|contractaddress: ${CONTRACT_ADDRESS}|g" $HOME/.fairyport/config.yml 

EXPOSE 9090

ENTRYPOINT ["./fairyport"]
CMD ["start", "--config", "$HOME/.fairyport/config.yml"]
