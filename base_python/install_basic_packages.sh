set -e
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y  --no-install-recommends \
        curl \
        gpg-agent \
        software-properties-common

curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
add-apt-repository 'deb http://apt.postgresql.org/pub/repos/apt/ zesty-pgdg main'
apt-get update

apt-get install -y --no-install-recommends \
    awscli \
    binutils \
    curl \
    dnsutils \
    gcc \
    git \
    iproute2 \
    iputils-ping \
    less \
    libdpkg-perl \
    lsof \
    make \
    net-tools \
    postgresql-client-10 \
    python3-dev python3-pip python3-venv \
    sudo \
    supervisor \
    vim

pip3 install -U pip==9.* setuptools wheel
pip3 install pillow uwsgi psycopg2-binary

curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
add-apt-repository "deb https://artifacts.elastic.co/packages/6.x/apt stable main"

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"


apt-get update && apt-get install -y --no-install-recommends filebeat docker-ce
