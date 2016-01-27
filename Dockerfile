FROM wordpress

MAINTAINER webfatorial <webfatorial@webfatorial.com>

RUN apt-get update
RUN apt-get -y install wget
RUN apt-get -y install libpcre3-dev
RUN apt-get -y install libmcrypt-dev
RUN apt-get -y install libfreetype6-dev
RUN apt-get -y install libjpeg62-turbo-dev
RUN apt-get -y install libmagickwand-dev
RUN apt-get -y install php5-common
RUN apt-get -y install php5-mcrypt
RUN apt-get -y install pngquant
RUN apt-get -y install sendmail

RUN rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install mcrypt

VOLUME /var/www/html
WORKDIR /var/www/html

ENV WORDPRESS_IS_LOCAL=false
ENV WORDPRESS_DISABLE_WP_CRON=false
ENV WORDPRESS_AWS_ACCESS_KEY_ID=
ENV WORDPRESS_AWS_SECRET_ACCESS_KEY=
ENV WORDPRESS_WP_DEBUG=false

COPY etc /etc

RUN wget http://static.jonof.id.au/dl/kenutils/pngout-20130221-linux.tar.gz \
    && tar xvf pngout-20130221-linux.tar.gz \
    && mv pngout-20130221-linux/x86_64/pngout /usr/bin \
    && rm -rf pngout-20130221-linux

RUN getent group www-data || groupadd www-data -g 33
RUN id -u www-data &>/dev/null || useradd -u 1000  --no-create-home --system --no-user-group www-data

RUN usermod -u 1000 www-data
RUN usermod -G staff www-data

COPY usr/src /usr/src

RUN chown -R www-data:www-data /usr/src
RUN chown -R www-data:www-data /var/www/html

RUN ls
RUN ls

COPY docker-entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh
