#!/usr/bin/env bash
set -e

if [ "$BUILD_HELM" = "1" ]; then
    HELM_VERSION=3.12.1
    HELMFILE_VERSION=0.155.0
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash -s -- --version v${HELM_VERSION}
    curl -L https://github.com/helmfile/helmfile/releases/download/v${HELMFILE_VERSION}/helmfile_${HELMFILE_VERSION}_linux_amd64.tar.gz -o helmfile.tgz
    tar xzf helmfile.tgz
    mv helmfile /usr/bin
    rm helmfile.tgz
fi
