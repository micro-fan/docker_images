# Images

## fan0/python

Usage with django:

```Dockerfile
# Build JS part

from node as js
RUN mkdir /front
ADD frontend/package.json /front/package.json
WORKDIR /front
RUN npm i

ADD frontend /front
RUN npm run build

# Build container itself
from fan0/python:2.2.0

ENV PGUSER=postgres
ENV PGHOST=postgres
ENV PGPORT=5432
ENV PGDATABASE=web_database
ENV CONTAINER_TYPE=web
ENV LOG_DIR=/var/log/web_logs
ENV PYTHONPATH=/home/code/backend:$PYTHONPATH

ADD backend/requirements.txt /home/code/backend/requirements.txt
RUN pip3 install -r /home/code/backend/requirements.txt
RUN pip3 install uwsgi

COPY --from=js /front/build/ /home/code/backend/static/jsapp
ADD . /home/code/.
EXPOSE 80

WORKDIR /home/code/
RUN mkdir -p $LOG_DIR && python3 backend/manage.py collectstatic --noinput
```

### Options
