FROM ronualdo/phoenix-api:v1.3.2

RUN mkdir /app
COPY . /app
WORKDIR /app

# installing Rust
RUN apk add --no-cache rust cargo

RUN mix deps.get && mix compile --force

CMD mix phx.server
