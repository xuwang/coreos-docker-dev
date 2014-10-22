FROM xuwang/apache-php:latest
# See https://github.com/ErikDubbelboer/phpRedisAdmin

RUN composer create-project -s dev erik-dubbelboer/php-redis-admin /var/www/html

ADD config/config.inc.php /var/www/html/includes/config.inc.php

EXPOSE 80