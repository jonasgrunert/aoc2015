FROM mcr.microsoft.com/devcontainers/base:alpine3.21
ARG GLEAM_VERSION=v1.11.1
RUN apk add erlang
RUN wget -O rebar3 https://s3.amazonaws.com/rebar3/rebar3 && chmod 777 ./rebar3 && ./rebar3 local install && rm ./rebar3 && export PATH=$PATH:~/.cache/rebar3/bin && wget -O gleam.tar.gz https://github.com/gleam-lang/gleam/releases/download/${GLEAM_VERSION}/gleam-v1.11.1-aarch64-unknown-linux-musl.tar.gz && tar -xf gleam.tar.gz -C /usr/local/bin && rm gleam.tar.gz