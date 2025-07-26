# syntax=docker/dockerfile:1.3-labs

FROM mcr.microsoft.com/devcontainers/base:alpine
RUN apk add gleam erlang
RUN wget -O rebar3 https://s3.amazonaws.com/rebar3/rebar3 && chmod 777 ./rebar3 && ./rebar3 local install && rm ./rebar3
RUN export PATH=$PATH:~/.cache/rebar3/bin