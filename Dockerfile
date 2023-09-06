ARG IMAGE
ARG TAG

FROM ${IMAGE} as parent
ENV MAVEN_CONFIG="" \
    SNYK_INTEGRATION_NAME="DOCKER_SNYK" \
    SNYK_INTEGRATION_VERSION=${TAG} \
    SNYK_CFG_DISABLESUGGESTIONS=true
WORKDIR /app
COPY docker-entrypoint.sh /usr/local/bin/
# RUN curl --compressed --output install-snyk.py https://raw.githubusercontent.com/snyk/cli/master/scripts/install-snyk.py
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["snyk", "test"]


FROM ubuntu as snyk
RUN apt-get update && apt-get install -y curl python3 python3-requests
RUN curl --compressed --output /usr/local/bin/install-snyk.py https://raw.githubusercontent.com/snyk/cli/b3c4926867de9e0d9d930c33bc02a49329a7bba2/scripts/install-snyk.py
RUN chmod +x /usr/local/bin/install-snyk.py
RUN install-snyk.py latest

FROM alpine as snyk-alpine
RUN apk update && apk add --no-cache git curl python3 py3-requests
RUN curl --compressed --output /usr/local/bin/install-snyk.py https://raw.githubusercontent.com/snyk/cli/b3c4926867de9e0d9d930c33bc02a49329a7bba2/scripts/install-snyk.py
RUN chmod +x /usr/local/bin/install-snyk.py
RUN install-snyk.py latest

FROM parent as alpine
RUN apk update && apk upgrade --no-cache
RUN apk add --no-cache libstdc++ git
COPY --from=snyk-alpine ./snyk /usr/local/bin/snyk

FROM parent as linux
COPY --from=snyk ./snyk /usr/local/bin/snyk
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y ca-certificates git
RUN apt-get auto-remove -y && apt-get clean -y && rm -rf /var/lib/apt/
