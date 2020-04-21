FROM php:7.1-apache

ENV APACHE_DOCUMENT_ROOT /var/www/html/webroot
# Vars
ENV DEBUG false
ENV WKHTML_TO_PDF_BIN /usr/bin/wkhtmltopdf

RUN apt-get update;
# pdftk needed Command
RUN mkdir -p /usr/share/man/man1mkdir -p /usr/share/man/man1
RUN apt-get install libpng-dev -y;
# RUN apt-get install libpng-dev wkhtmltopdf -y;
RUN apt-get install wget libfontenc1 xfonts-75dpi xfonts-base xfonts-encodings xfonts-utils openssl build-essential libssl-dev libxrender-dev git-core libx11-dev libxext-dev libfontconfig1-dev libfreetype6-dev fontconfig -y;
RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.stretch_amd64.deb;
RUN dpkg -i wkhtmltox_0.12.5-1.stretch_amd64.deb;
RUN echo "date.timezone = Europe/Berlin" >> $PHP_INI_DIR/php.ini
RUN echo "error_reporting = E_ALL & ~E_NOTICE & ~E_STRICT" >> $PHP_INI_DIR/php.ini

RUN apt-get update && apt-get install -y zlib1g-dev libicu-dev g++ pdftk
RUN docker-php-ext-configure intl

RUN docker-php-ext-install intl mysqli pdo pdo_mysql gd mbstring zip
RUN cp /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --install-dir=/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"

# RUN chown www-data:www-data -R /var/www/html
# RUN composer require