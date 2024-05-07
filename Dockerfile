FROM ubuntu:23.10

ARG RUNNER_VERSION="2.316.1"

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && apt -qq update \
    && apt install -y --no-install-recommends ca-certificates curl libicu-dev jq buildah podman jq libarchive-tools gnupg skopeo

USER ubuntu
WORKDIR /home/ubuntu

RUN curl -sS -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz | tar xz

COPY start.sh start.sh

CMD ["./start.sh"]
