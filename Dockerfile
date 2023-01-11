FROM python:3.11-slim
USER root
RUN apt update
RUN pip3 install -r requirements.txt