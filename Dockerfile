FROM ubuntu:22.04

LABEL maintainer "Andreas Fertig"

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl wget gnupg unzip python3 python3-pip python3-setuptools libsqlite3-dev apt-transport-https \
    ca-certificates \
    curl \
    sqlite3 \
    software-properties-common && apt-get update

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

RUN add-apt-repository \
   "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

RUN apt-get update && apt-get install -y --no-install-recommends docker-ce

RUN useradd insights \
    && mkdir /home/insights \
    && chown -R insights:insights /home/insights

COPY latest.zip /tmp

RUN cd /tmp && \
	unzip latest.zip && \
    mv cppinsights-web-latest /home/insights/cppinsights-web && \
    rm -rf /tmp/* && \
    chown -R insights:insights /home/insights

RUN grep -v pysqlite3-binary /home/insights/cppinsights-web/requirements.txt > /home/insights/cppinsights-web/requirements2.txt && \
    mv /home/insights/cppinsights-web/requirements2.txt /home/insights/cppinsights-web/requirements.txt && \
    pip3 install -r /home/insights/cppinsights-web/requirements.txt

EXPOSE 5000

#VOLUME /var/run/docker.sock

COPY run_in_docker.sh /
RUN chmod 0755 /run_in_docker.sh

#USER insights

CMD ["/run_in_docker.sh"]
