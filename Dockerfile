FROM ubuntu:18.04

LABEL maintainer "Andreas Fertig"

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl wget gnupg unzip python3 python3-pip apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common && apt-get update

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

RuN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

RUN apt-get update && apt-get install -y --no-install-recommends docker-ce

RUN useradd insights \
    && mkdir /home/insights \
    && chown -R insights:insights /home/insights

RUN cd /tmp && wget https://github.com/andreasfertig/cppinsights-web/archive/latest.zip && \
	unzip latest.zip && \
    mv cppinsights-web-latest /home/insights/cppinsights-web && \
    rm -rf /tmp/* && \
    chown -R insights:insights /home/insights

RUN pip3 install -r /home/insights/cppinsights-web/requirements.txt

EXPOSE 5000

#VOLUME /var/run/docker.sock

COPY run_in_docker.sh /
RUN chmod 0755 /run_in_docker.sh

#USER insights

CMD ["/run_in_docker.sh"]
