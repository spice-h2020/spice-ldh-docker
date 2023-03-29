FROM php:7.4-apache
ARG PORTAL_VERSION
# File Author / Maintainer
LABEL maintainer="Jason Carvalho https://github.com/JaseMK"
LABEL version="1.0_$PORTAL_VERSION"
LABEL description="SPICE LDH Portal"

COPY 000-Default.conf /etc/apache2/sites-enabled/000-Default.conf
COPY spice-datahub-php.ini /usr/local/etc/php/conf.d/spice-datahub-php.ini
RUN a2enmod rewrite
RUN apt-get update && apt-get install -y apt-utils libicu-dev git
RUN apt-get install -y libcurl4-openssl-dev pkg-config libssl-dev unzip

RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl
RUN curl -sS https://getcomposer.org/installer | php -- --version=1.10.22 --install-dir=/usr/local/bin --filename=composer \
    && composer self-update --1 && ln -s $(composer config --global home) /root/composer
ENV PATH=$PATH:/root/composer/vendor/bin COMPOSER_ALLOW_SUPERUSER=1

RUN cd /var/www && git clone https://github.com/spice-h2020/linked-data-hub.git && cd /var/www/linked-data-hub && git checkout $PORTAL_VERSION
COPY config-local.php /var/www/linked-data-hub/config/autoload/local.php
RUN cd /var/www/linked-data-hub && composer install && composer dump-autoload
RUN chown -R www-data:www-data /var/www

## Setup backend data via API
# 'spice_rdfjobs2' 'rdfjobskey012'
# RUN curl -X POST "http://spice-ldh-api:8090/management/datasets" --user spice-admin:DATAHUB1234567890 -H "accept: */*" -H "Content-Type: application/x-www-form-urlencoded" -d "dataset-uuid=spice_rdfjobs2&key=rdfjobskey012"
# # 'spice_policies' 'policieskey012'
# RUN curl -X POST "http://spice-ldh-api:8090/management/datasets" --user spice-admin:DATAHUB1234567890 -H "accept: */*" -H "Content-Type: application/x-www-form-urlencoded" -d "dataset-uuid=spice_policies&key=policieskey012"
# # 'spice_policies_requests' 'policieskey012'
# RUN curl -X POST "http://spice-ldh-api:8090/management/datasets" --user spice-admin:DATAHUB1234567890 -H "accept: */*" -H "Content-Type: application/x-www-form-urlencoded" -d "dataset-uuid=spice_policies_requests&key=policieskey012"
# # 'spice_notifications' 'notificationskey023'
# RUN curl -X POST "http://spice-ldh-api:8090/management/datasets" --user spice-admin:DATAHUB1234567890 -H "accept: */*" -H "Content-Type: application/x-www-form-urlencoded" -d "dataset-uuid=spice_notifications&key=notificationskey023"




