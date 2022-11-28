FROM python:3.9.7-alpine

RUN adduser -D california
USER california

WORKDIR /home/california

COPY requirements.txt requirements.txt
RUN python -m venv venv
RUN venv/bin/pip install -r requirements.txt

COPY app app
COPY wsgi.py runtime.txt boot.sh ./

EXPOSE 5000
ENTRYPOINT ["./boot.sh"]
