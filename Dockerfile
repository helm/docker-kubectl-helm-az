# Upgrade the helm client version here when the az cluster tiller version
# upgrades.
FROM lachlanevenson/k8s-helm:v3.0.0

FROM lachlanevenson/k8s-kubectl:v1.16.3

# We build our own base az alpine image becase all official images currently
# have security vulnerabilities (as of mcr.microsoft.com/azure-cli:2.0.64).
# Ref: https://github.com/Azure/azure-cli/issues/9167
FROM alpine:3.10
ENV AZ 2.0.76
RUN apk add -U python3 bash ca-certificates && \
    apk add --virtual=build gcc python3-dev musl-dev libffi-dev openssl-dev make  && \
    pip3 install --upgrade requests && \
    pip3 install azure-cli==${AZ} && \
    ln -s /usr/bin/python3 /usr/bin/python
COPY --from=0 /usr/local/bin/helm /usr/local/bin/helm
COPY --from=1 /usr/local/bin/kubectl /usr/local/bin/kubectl
