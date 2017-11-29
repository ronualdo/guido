FROM elixir:1.5.2

RUN mix local.hex --force

RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force

RUN mkdir /app
COPY . /app
WORKDIR /app

# installing Rust
RUN mkdir /app/.cargo
ENV CARGO_HOME=/app/.cargo
ENV PATH=$CARGO_HOME/bin:$PATH
RUN curl -O https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init
RUN chmod +x rustup-init && ./rustup-init -y
RUN rustc --version

RUN mix deps.get
RUN mix compile

CMD mix phx.server
