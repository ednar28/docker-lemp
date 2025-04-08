# Use the official PHP 8.3 FPM image as the base image
FROM php:8.3-fpm

# Set working directory
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
  git \
  unzip \
  libpng-dev \
  libldap2-dev \
  libsodium-dev \
  libonig-dev \
  libxml2-dev \
  zip \
  curl \
  && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set permissions for Laravel
RUN chown -R www-data:www-data /var/www/html \
  && chmod -R 755 /var/www/html

# Expose port 9000 and start PHP-FPM server
EXPOSE 9000
CMD ["php-fpm"]