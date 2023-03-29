FROM php:7.2-apache
ARG APIF_VERSION
RUN test -n "$APIF_VERSION"
# File Author / Maintainer
LABEL maintainer="Jason Carvalho https://github.com/JaseMK"
LABEL version="1.0_$APIF_VERSION"
LABEL description="SPICE LDH API image."

RUN apt-get update && apt-get install -y apt-utils git
RUN apt-get install -y libcurl4-openssl-dev pkg-config libssl-dev unzip
RUN pecl install mongodb

RUN echo "extension=mongodb" | tee /usr/local/etc/php/conf.d/mongodb.ini
COPY 000-Default.conf /etc/apache2/sites-enabled/000-Default.conf

#RUN echo "<?php phpinfo(); " | tee /var/www/html/phpinfo.php

RUN a2enmod rewrite

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer self-update --1 && ln -s $(composer config --global home) /root/composer
ENV PATH=$PATH:/root/composer/vendor/bin COMPOSER_ALLOW_SUPERUSER=1

RUN cd /var/www && git clone https://github.com/mkdf/api-factory.git && cd /var/www/api-factory && git checkout $APIF_VERSION
COPY config-local.php /var/www/api-factory/config/autoload/local.php
RUN cd /var/www/api-factory && composer install && composer dump-autoload
RUN chown -R www-data:www-data /var/www

EXPOSE 80

#CMD apachectl -D FOREGROUND
