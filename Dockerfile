FROM ubuntu:latest
# install supervisor and tools
RUN apt update -y
RUN apt upgrade -y
RUN apt install vim -y
RUN apt install pip -y
RUN pip install supervisor
RUN apt install mariadb-server -y
RUN apt install net-tools -y
RUN apt install curl -y
RUN apt install wget -y
# install exporter
WORKDIR /usr/local
RUN wget https://github.com/prometheus/mysqld_exporter/releases/download/v0.13.0/mysqld_exporter-0.13.0.linux-amd64.tar.gz
RUN tar -xf mysqld_exporter-0.13.0.linux-amd64.tar.gz
# install consul agent
RUN DEBIAN_FRONTEND=noninteractive apt install software-properties-common -y
RUN apt-get install -y lsb-release
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN apt-get update -y && apt-get install consul -y
# install prometheus
RUN wget https://github.com/prometheus/prometheus/releases/download/v2.33.1/prometheus-2.33.1.linux-amd64.tar.gz
RUN tar -xf prometheus-2.33.1.linux-amd64.tar.gz

COPY supervisord.conf /usr/local/supervisord.conf
COPY . .
RUN mkdir -p /var/run/mysqld
RUN chown mysql /var/run/mysqld