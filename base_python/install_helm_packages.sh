#!/usr/bin/env bash
set -e

if [ "$BUILD_HELM" = "1" ]; then
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash -s -- --version v3.8.2
    curl -L https://github.com/helmfile/helmfile/releases/download/v0.145.1/helmfile_0.145.1_linux_amd64.tar.gz -o helmfile.tgz
    tar xzf helmfile.tgz
    mv helmfile /usr/bin
    rm helmfile.tgz
fi
