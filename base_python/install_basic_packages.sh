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

apt -y install python3.9 python3.9-venv python3.9-dev
update-alternatives --install /usr/bin/python python /usr/bin/python3.9 1
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3.9 get-pip.py

python3 -m pip install -U setuptools wheel supervisor
python3 -m pip install pillow uwsgi psycopg2-binary fan-tools==3.* awscli==1.20.13 docker-compose
