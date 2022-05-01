FROM python:3.10.4-slim-bullseye

# alias
RUN echo "alias ll='ls -lahF'" >> ~/.bashrc

# work directory
WORKDIR /share
