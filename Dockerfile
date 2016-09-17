FROM dockerizedrupal/base-debian-jessie:2.0.0

MAINTAINER Jürgen Viljaste <j.viljaste@gmail.com>

LABEL vendor=dockerizedrupal.com

ENV TERM xterm

ADD ./src /src

RUN /src/entrypoint.sh build

VOLUME ["/vsftpd"]

EXPOSE 21
EXPOSE 20
EXPOSE 50000-50002

ENTRYPOINT ["/src/entrypoint.sh", "run"]
