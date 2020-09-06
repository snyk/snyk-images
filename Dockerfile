ARG IMAGE
ARG TAG

FROM ${IMAGE} as parent
ENV MAVEN_CONFIG="" \
    SNYK_INTEGRATION_NAME="DOCKER_SNYK" \
    SNYK_INTEGRATION_VERSION=${TAG} \
    SNYK_CFG_DISABLESUGGESTIONS=true
WORKDIR /app
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["snyk", "test"]


FROM ubuntu as snyk
RUN apt-get update && apt-get install -y curl wget
RUN curl -s https://api.github.com/repos/snyk/snyk/releases/latest | grep "browser_download_url" | grep linux | cut -d '"' -f 4 | wget -i - && \
    sha256sum -c snyk-linux.sha256 && \
    mv snyk-linux /usr/local/bin/snyk && \
    chmod +x /usr/local/bin/snyk


FROM alpine as snyk-alpine
RUN apk add --no-cache curl wget
RUN curl -s https://api.github.com/repos/snyk/snyk/releases/latest | grep "browser_download_url" | grep alpine | cut -d '"' -f 4 | wget -i - && \
    sha256sum -c snyk-alpine.sha256 && \
    mv snyk-alpine /usr/local/bin/snyk && \
    chmod +x /usr/local/bin/snyk


FROM parent as alpine
RUN apk add --no-cache libstdc++
COPY --from=snyk-alpine /usr/local/bin/snyk /usr/local/bin/snyk


FROM parent as linux
COPY --from=snyk /usr/local/bin/snyk /usr/local/bin/snyk
