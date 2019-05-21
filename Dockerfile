# Upgrade the helm client version here when the az cluster tiller version
# upgrades.
FROM lachlanevenson/k8s-helm:v2.13.1

FROM lachlanevenson/k8s-kubectl:v1.14.1

# We use mcr.microsoft.com/azure-cli image registry rather than
# https://hub.docker.com/r/microsoft/azure-cli/ because we want a versioned
# image tag, but "latest" is the only tag pushed to that repo in the past two
# months.
FROM mcr.microsoft.com/azure-cli:2.0.64
# See https://www.alpinelinux.org/posts/Docker-image-vulnerability-CVE-2019-5021.html
RUN sed -i -e 's/^root::/root:!:/' /etc/shadow
COPY --from=0 /usr/local/bin/helm /usr/local/bin/helm
COPY --from=1 /usr/local/bin/kubectl /usr/local/bin/kubectl
