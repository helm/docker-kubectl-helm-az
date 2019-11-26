# Upgrade the helm client version here when the az cluster tiller version
# upgrades.
FROM lachlanevenson/k8s-helm:v2.14.3

FROM lachlanevenson/k8s-kubectl:v1.14.1

# We build our own base az alpine image because all official images currently
# have security vulnerabilities (as of mcr.microsoft.com/azure-cli:2.0.64).
# Ref: https://github.com/Azure/azure-cli/issues/9167
FROM alpine:3.10
ENV AZ 2.0.77
RUN apk add -U --no-cache git python3 bash ca-certificates && \
    apk add --virtual=build gcc python3-dev musl-dev libffi-dev openssl-dev make  && \
    pip3 install --upgrade pip requests && \
    pip3 install azure-cli==${AZ} && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    wget -O /tmp/helm-local-chart-version-0.0.6-linux-amd64.tar.gz https://github.com/mbenabda/helm-local-chart-version/releases/download/v0.0.6/helm-local-chart-version-0.0.6-linux-amd64.tar.gz && \
    cd /usr/local/bin && \
    tar -zxvf /tmp/helm-local-chart-version-0.0.6-linux-amd64.tar.gz local-chart-version && \
    rm /tmp/helm-local-chart-version-0.0.6-linux-amd64.tar.gz

COPY --from=0 /usr/local/bin/helm /usr/local/bin/helm
COPY --from=1 /usr/local/bin/kubectl /usr/local/bin/kubectl
