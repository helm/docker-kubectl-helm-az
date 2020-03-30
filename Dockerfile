FROM mcr.microsoft.com/azure-cli:2.2.0

ARG HELM_VERSION="v2.16.3"
ARG HELM_PLUGIN_VERSION="0.0.7"

RUN apk add --update -t deps \
      ca-certificates \
      curl \
      git \
      openssl \
      maven

RUN curl -Ls https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl \
      -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl

RUN curl -Ls https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz \
      -o helm-${HELM_VERSION}-linux-amd64.tar.gz \
 && tar -xf helm-${HELM_VERSION}-linux-amd64.tar.gz \
 && mv linux-amd64/helm /usr/local/bin \
 && rm -f /helm-${HELM_VERSION}-linux-amd64.tar.gz

RUN curl -Ls https://github.com/adesso-as-a-service/helm-local-chart-version/releases/download/v${HELM_PLUGIN_VERSION}/helm-local-chart-version-${HELM_PLUGIN_VERSION}-linux-amd64.tar.gz \
      -o /tmp/helm-local-chart-version-${HELM_PLUGIN_VERSION}-linux-amd64.tar.gz \
 && cd /usr/local/bin \
 && tar -zxf /tmp/helm-local-chart-version-${HELM_PLUGIN_VERSION}-linux-amd64.tar.gz local-chart-version \
 && rm /tmp/helm-local-chart-version-${HELM_PLUGIN_VERSION}-linux-amd64.tar.gz

RUN apk del --purge deps \
 && rm /var/cache/apk/*
