FROM php:7.4-fpm

# -------------------------------------------
# Softwares
# ---------------------------------------------
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends libzip-dev libpq-dev zip unzip \
    libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    libxslt-dev

# -------------------------------------------
# Xsl
# ---------------------------------------------
RUN docker-php-ext-install xsl && docker-php-ext-enable xsl

# ----------------------
# GD  
# ----------------------
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd

# ----------------------
# Postgres  
# ----------------------
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql 
RUN docker-php-ext-install pdo pdo_pgsql pgsql

# ----------------------
# INTL
# ----------------------
RUN docker-php-ext-configure intl
RUN docker-php-ext-install json calendar intl

# ----------------------
# ZIP
# ----------------------
RUN docker-php-ext-install zip

# ----------------------
# EXIF
# ----------------------
RUN docker-php-ext-install exif && docker-php-ext-enable exif

# ----------------------
# Composer
# ----------------------
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# ----------------------
# Nodejs
# ----------------------
RUN curl -sL https://deb.nodesource.com/setup_15.x | bash -
RUN apt-get install -y nodejs
