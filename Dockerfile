FROM lachlanevenson/k8s-helm:v2.16.3
FROM lachlanevenson/k8s-kubectl:v1.17.4
FROM mcr.microsoft.com/azure-cli:2.2.0

RUN wget -O /tmp/helm-local-chart-version-0.0.6-linux-amd64.tar.gz https://github.com/mbenabda/helm-local-chart-version/releases/download/v0.0.6/helm-local-chart-version-0.0.6-linux-amd64.tar.gz && \
    cd /usr/local/bin && \
    tar -zxvf /tmp/helm-local-chart-version-0.0.6-linux-amd64.tar.gz local-chart-version && \
    rm /tmp/helm-local-chart-version-0.0.6-linux-amd64.tar.gz

COPY --from=0 /usr/local/bin/helm /usr/local/bin/helm
COPY --from=1 /usr/local/bin/kubectl /usr/local/bin/kubectl
