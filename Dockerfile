FROM python:3-alpine
ENV PYTHONUNBUFFERED 1

RUN apk update
RUN apk -U upgrade

RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers libressl-dev musl-dev libffi-dev cargo

COPY ./requirements.txt /requirements.txt
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
RUN chmod -R 777 /app