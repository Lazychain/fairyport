FROM golang:1.21-bullseye

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="$HOME/.cargo/bin:${PATH}"

WORKDIR /app

COPY . .

RUN make build
RUN ./fairyport init

EXPOSE 9090

ENTRYPOINT ["./fairyport"]
CMD ["start", "--config", "$HOME/.fairyroot/config.yml"]
