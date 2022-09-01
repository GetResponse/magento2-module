ARG MAGENTO_APP_TAG=latest
ARG GETRESPONSE_MODULE_TAG=1.2.6
FROM docker.int.getresponse.com/integrations/magento/magento-app:$MAGENTO_APP_TAG
WORKDIR /magento-app
ENV COMPOSER_HOME /.composer
COPY --from=docker.int.getresponse.com/docker/composer:2 /usr/bin/composer /usr/bin/composer
USER root
RUN --mount=type=secret,id=composer COMPOSER_AUTH="`cat /run/secrets/composer`" composer require getresponse/magento2-module:$GETRESPONSE_MODULE_TAG
RUN chown -R www-data:www-data .
USER www-data


