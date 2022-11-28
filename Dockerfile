FROM python:3.9

WORKDIR /home/california

RUN apt-get update

COPY requirements.txt requirements.txt
RUN python -m venv venv
RUN venv/bin/pip install -r requirements.txt

COPY app app
COPY wsgi.py runtime.txt boot.sh ./

EXPOSE 5000
ENTRYPOINT ["python3", "./boot.sh"]
