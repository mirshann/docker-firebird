FROM ubuntu:16.04

MAINTAINER Bogdanov Evgeny <bogdanov.e@milandr.ru>

ENV DEBIAN_FRONTEND=noninteractiv

ADD "https://downloads.sourceforge.net/project/firebird/firebird-linux-amd64/3.0.2-Release/Firebird-3.0.2.32703-0.amd64.tar.gz" /usr/src/
WORKDIR /usr/src/Firebird-3.0.2.32703-0.amd64/
RUN echo 'Update, Upgrade and install dependences...' \
    && apt-get update \
    && apt-get install -y \
        gzip \
        libtommath0 \
    && mkdir /sqlbase \
    && ./install.sh -silent \
    &&  cat /opt/firebird/SYSDBA.password \
    && apt-get purge -y --allow-remove-essential --autoremove \
        gzip
WORKDIR /opt/firebird/bin
#cat /opt/firebird/SYSDBA.password passwd

VOLUME ["/sqlbase"]

EXPOSE 3050/tcp

CMD ["fbguard"]
