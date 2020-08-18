FROM alpine

LABEL "repository"="https://github.com/JasWoolieX/git-sync"
LABEL "homepage"="https://github.com/JasWoolieX/git-sync"
LABEL "maintainer"="Jas <github@weispot.com>"

RUN apk add --no-cache git openssh-client && \
  echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

ADD *.sh /

ENTRYPOINT ["/entrypoint.sh"]
