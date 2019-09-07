ARG IMAGE

FROM ${IMAGE} as parent


FROM parent as Alpine

RUN apk add --no-cache curl wget gcc
RUN curl -s https://api.github.com/repos/snyk/snyk/releases/latest | grep "browser_download_url" | grep alpine | cut -d '"' -f 4 | wget -i - && \
    sha256sum -c snyk-alpine.sha256 && \
    mv snyk-alpine /usr/local/bin/snyk && \
    chmod +x /usr/local/bin/snyk


FROM parent

RUN curl -s https://api.github.com/repos/snyk/snyk/releases/latest | grep "browser_download_url" | grep linux | cut -d '"' -f 4 | wget -i - && \
    sha256sum -c snyk-linux.sha256 && \
    mv snyk-linux /usr/local/bin/snyk && \
    chmod +x /usr/local/bin/snyk
