set -e
export DEBIAN_FRONTEND=noninteractive
PY_VERSION=3.10

apt-get update
apt-get install -y  --no-install-recommends \
        curl \
        gpg-agent \
        sudo \
        software-properties-common

curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
add-apt-repository 'deb http://apt.postgresql.org/pub/repos/apt/ jammy-pgdg main'
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# add-apt-repository ppa:deadsnakes/ppa

apt-get update && apt-get install -y --no-install-recommends docker-ce

apt-get install -y --no-install-recommends \
    binutils \
    curl \
    dnsutils \
    gcc \
    gdal-bin \
    git \
    iproute2 \
    iputils-ping \
    less \
    libdpkg-perl \
    libpcre3-dev \
    lsof \
    make \
    net-tools \
    postgresql-client-13 \
    vim

apt -y install python${PY_VERSION} python${PY_VERSION}-venv python${PY_VERSION}-dev python3-pip
update-alternatives --install /usr/bin/python python /usr/bin/python${PY_VERSION} 1
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python${PY_VERSION} 1

#python3 -m ensurepip --upgrade

python3 -m pip install -U setuptools wheel supervisor
python3 -m pip install pillow uwsgi psycopg2-binary fan-tools==3.* awscli docker-compose

cd /usr/local/bin/
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubens
curl -LO https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubectx
chmod a+x kubectl kubectx kubens
