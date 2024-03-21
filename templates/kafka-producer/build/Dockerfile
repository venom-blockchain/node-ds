FROM rust:1.76.0-slim-buster as build

WORKDIR /app

RUN apt update && apt install git build-essential libssl-dev pkg-config curl clang libsasl2-dev -y
RUN git clone https://github.com/broxus/ton-kafka-producer.git && \
  cd ton-kafka-producer && \
  RUSTFLAGS='-C target_cpu=native' cargo build --release --features="venom"

FROM rust:1.76.0-slim-buster
WORKDIR /app
RUN apt update && apt install libsasl2-dev -y
COPY --from=build /app/ton-kafka-producer/target/release/ton-kafka-producer /app/ton-kafka-producer
ENTRYPOINT [ "/app/ton-kafka-producer" ]
