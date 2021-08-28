FROM base_python

ADD app/ /app/
WORKDIR /app

RUN python3 -m venv venv && ./venv/bin/pip install wheel && ./venv/bin/pip install -r requirements.txt
