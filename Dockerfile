ARG IMAGE

FROM ${IMAGE} as parent
WORKDIR /app
ENTRYPOINT ["snyk"]
CMD ["test"]


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


FROM parent as Alpine
RUN apk add --no-cache libstdc++
COPY --from=snyk-alpine /usr/local/bin/snyk /usr/local/bin/snyk


FROM parent
COPY --from=snyk /usr/local/bin/snyk /usr/local/bin/snyk
