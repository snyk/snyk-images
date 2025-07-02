# syntax=docker/dockerfile:1
# check=skip=InvalidDefaultArgInFrom
ARG IMAGE
ARG CLI_VERSION=latest

FROM ${IMAGE} AS parent

ARG TAG
ARG CLI_VERSION=latest

ENV MAVEN_CONFIG="" \
    SNYK_INTEGRATION_NAME="DOCKER_SNYK" \
    SNYK_INTEGRATION_VERSION=${TAG} \
    SNYK_CFG_DISABLESUGGESTIONS=true \
    SNYK_CLI_VERSION=${CLI_VERSION}

WORKDIR /app
COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["snyk", "test"]

FROM parent AS alpine

RUN apk update \
    && apk upgrade --no-cache \
    && apk add --no-cache \
    libstdc++ \
    git \
    && rm -rf /var/cache/apk/*

COPY --from=snyk/snyk:base-alpine snyk /usr/local/bin/snyk

FROM parent AS linux

RUN apt-get update \
    && apt-get install -y \
    ca-certificates \
    git \
    && apt-get auto-remove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

COPY --from=snyk/snyk:base-ubuntu snyk /usr/local/bin/snyk
