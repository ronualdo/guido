FROM elixir:1.6.1

RUN mix local.hex --force

RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force

RUN mkdir /app
COPY . /app
WORKDIR /app

# installing Rust
ENV CARGO_HOME=/app/.cargo
ENV PATH=$CARGO_HOME/bin:$PATH
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

RUN mix deps.get && mix local.rebar --force && mix compile --force

CMD mix phx.server
