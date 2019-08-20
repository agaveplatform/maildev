FROM djfarrelly/maildev:1.10

MAINTAINER Rion Dooley <deardooley@gmail.com>

ADD entrypoint.sh /docker-entrypoint.sh

ADD rules.json /data/rules.json

RUN /docker-entrypoint.sh

# web amd smtp port
EXPOSE 1025 80

ENTRYPOINT "/bin/entrypoint.sh"git remote add origin git@github.com:agaveplatform/maildev.git