# webfatorial/docker-wordpress

WordPress extended version: provides a version of WordPress with some php modules.
This version is configured to use /app to content (wp-content) and /core to WordPress

WordPress Login in (host)/core/wp-admin

## Extras wp-config Environments

* WORDPRESS_IS_LOCAL
* WORDPRESS_DISABLE_WP_CRON
* WORDPRESS_AWS_ACCESS_KEY_ID
* WORDPRESS_AWS_SECRET_ACCESS_KEY
* WORDPRESS_WP_DEBUG

### Extras

* libfreetype6-dev
* libjpeg-progs
* libjpeg62-turbo-dev
* libmagickwand-dev
* libpng12-dev
* mcrypt
* pngout
* sendmail

## Docker Compose example

```
wordpress:
    image: webfatorial/wordpress
    environment:
        - WORDPRESS_DISABLE_WP_CRON=true
    links:
        - mysql
    ports:
        - 80:80
    volumes:
        - ./src/app:/var/www/html/app
```