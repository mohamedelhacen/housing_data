FROM python:3.9.7-alpine

RUN adduser -D california
USER california

WORKDIR /home/california

COPY requirements.yml requirements.yml
# RUN python -m venv venv
# RUN venv/bin/pip install -r requirements.txt
RUN apt-get update

RUN apt-get install -y wget && rm -rf /var/lib/apt/lists/*

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 

RUN conda env create -f environment.yml 

COPY app app
COPY wsgi.py runtime.txt boot.sh ./

EXPOSE 5000
ENTRYPOINT ["./boot.sh"]
