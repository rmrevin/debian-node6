FROM node:6.8

MAINTAINER Revin Roman <roman@rmrevin.com>

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN set -xe \
 && apt-get update -qq \
 && apt-get install -y --no-install-recommends \
        apt-utils bash-completion ca-certificates net-tools ssh-client \
        gcc make rsync chrpath curl wget rsync git vim unzip bzip2

ONBUILD ARG _UID
ONBUILD ARG _GID

ONBUILD RUN groupmod -g $_GID www-data \
 && usermod -u $_UID -g $_GID -s /bin/bash www-data \
 && echo "    IdentityFile ~/.ssh/id_rsa" >> /etc/ssh/ssh_config

RUN mkdir -p /var/www/ \
 && mkdir -p /var/run/php/ \
 && mkdir -p /var/log/php/ \
 && mkdir -p /var/log/app/ \
 && chown www-data:www-data /var/www/

RUN set -xe \
 && npm install -g gulp bower phantomjs

RUN rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/

CMD while true; do sleep 1000; done
