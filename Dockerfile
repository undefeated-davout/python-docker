FROM python:3.10.4-slim-bullseye

# alias
RUN echo "alias ll='ls -lahF --color=auto'" >> ~/.bashrc

WORKDIR /opt/src/app/
