FROM alpine:3.22

# Install dependencies
RUN apk add --no-cache curl bash git gnupg tar openssh age

# Install helm
ENV HELM_VERSION="v3.18.4"
RUN curl -L https://get.helm.sh/helm-${HELM_VERSION}-linux-arm64.tar.gz | tar -xz && \
    mv linux-arm64/helm /usr/local/bin/helm && rm -rf linux-arm64

ENV SOPS_VERSION="v3.10.2"
RUN curl -L https://github.com/mozilla/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux.arm64 -o /usr/local/bin/sops && chmod -x /usr/local/bin/sops


# Install helmfile
ENV HELMFILE_VERSION="v1.1.3"
RUN curl -L https://github.com/helmfile/helmfile/releases/download/${HELMFILE_VERSION}/helmfile_linux_arm64 -o /usr/local/bin/helmfile && chmod +x /usr/local/bin/helmfile

# Install helm plugins
RUN helm plugin install https://github.com/jkroepke/helm-secrets --version v4.6.5 && \
    helm plugin install https://github.com/databus23/helm-diff --version v3.12.3

# Env for helm plugins
ENV HELM_PLUGINS=/home/argocd/.local/share/helm/plugins

# Launch gRPC plugin sidecar
ENTRYPOINT ["helmfile", "plugin", "sidecar"]
