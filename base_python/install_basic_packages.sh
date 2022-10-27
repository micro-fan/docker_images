set -e
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y  --no-install-recommends \
        curl \
        gpg-agent \
        sudo \
        software-properties-common

curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
add-apt-repository 'deb http://apt.postgresql.org/pub/repos/apt/ focal-pgdg main'
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
add-apt-repository ppa:deadsnakes/ppa

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

apt -y install python3.10 python3.10-venv python3.10-dev
update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3.10 get-pip.py

python3 -m pip install -U setuptools wheel supervisor
python3 -m pip install pillow uwsgi psycopg2-binary fan-tools==3.* awscli==1.20.13 docker-compose

cd /usr/local/bin/

KUBE_RELEASE=v1.22.11
curl -LO "https://dl.k8s.io/release/${KUBE_RELEASE}/bin/linux/amd64/kubectl"
curl -LO https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubens
curl -LO https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubectx

XH_VERSION=v0.16.1
XH_BASE=xh-${XH_VERSION}-x86_64-unknown-linux-musl
XH_URL=https://github.com/ducaale/xh/releases/download/${XH_VERSION}/${XH_BASE}.tar.gz

curl -L $XH_URL -o xh.tar.gz
tar xzf xh.tar.gz
mv $XH_BASE/xh /usr/local/bin/.
rm -rf xh.tar.gz $XH_BASE


chmod a+x kubectl kubectx kubens xh
