FROM python:3.9

WORKDIR /home/california

RUN apt-get update

COPY requirements.txt requirements.txt
# RUN python -m venv venv
RUN pip install --upgrade pip && pip install -r requirements.txt

COPY app app
COPY wsgi.py runtime.txt boot.sh ./

CMD exec gunicorn -b 0.0.0.0:5000 --access-logfile - --error-logfile - wsgi:app
