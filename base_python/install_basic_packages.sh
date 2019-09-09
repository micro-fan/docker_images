set -e
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y  --no-install-recommends \
        curl \
        gpg-agent \
        sudo \
        software-properties-common

curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
add-apt-repository 'deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main'
curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
add-apt-repository "deb https://artifacts.elastic.co/packages/6.x/apt stable main"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt-get update && apt-get install -y --no-install-recommends filebeat docker-ce

apt-get install -y --no-install-recommends \
    awscli \
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
    postgresql-client-10 \
    python3.7-dev python3.7-venv python3-pip \
    vim

update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1
python3 -m pip install -U pip==9.* setuptools wheel supervisor
python3 -m pip install pillow uwsgi psycopg2-binary
