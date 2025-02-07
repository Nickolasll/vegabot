FROM alpine:3.9

ENV PYTHONPATH /app
ENV PYTHON_VERSION 3.6.9-r3
ENV APP_DIR /app

RUN mkdir $APP_DIR

WORKDIR $APP_DIR

COPY requirements.txt ./
COPY uwsgi.ini ./
COPY main.py ./

RUN apk add build-base python3=$PYTHON_VERSION python3-dev gcc musl-dev linux-headers \
    && pip3 install -r /app/requirements.txt \
    && rm -rf /var/cache/* \
    && rm -rf /root/.cache/*

CMD ["uwsgi", "--ini", "/app/uwsgi.ini"]