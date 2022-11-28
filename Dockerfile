FROM python:3.9.7-alpine

RUN adduser -D california
USER california

WORKDIR /home/california

COPY requirements.yml requirements.yml
# RUN python -m venv venv
# RUN venv/bin/pip install -r requirements.txt
RUN conda env create -f environment.yml 

COPY app app
COPY wsgi.py runtime.txt boot.sh ./

EXPOSE 5000
ENTRYPOINT ["./boot.sh"]
