# PHP based on openSUSE 16.0
FROM ghcr.io/fab-infra/base-image:opensuse16.0

# Additional repositories
RUN zypper ar -cfp 90 https://download.opensuse.org/repositories/server:/php:/applications/16.0/ server:php:applications &&\
	zypper ar -cfp 90 http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_16.0/Essentials packman-essentials &&\
	zypper --gpg-auto-import-keys ref &&\
	zypper clean -a

# PHP with modules
RUN zypper in -y php8 php8-devel \
	php8-bcmath \
	php8-bz2 \
	php8-ctype \
	php8-curl \
	php8-dom \
	php8-exif \
	php8-fileinfo \
	php8-ftp \
	php8-gd \
	php8-gettext \
	php8-gmp \
	php8-iconv \
	php8-intl \
	php8-ldap \
	php8-mbstring \
	php8-mysql \
	php8-opcache \
	php8-openssl \
	php8-pcntl \
	php8-pdo \
	php8-phar \
	php8-posix \
	php8-redis \
	php8-soap \
	php8-sodium \
	php8-tidy \
	php8-tokenizer \
	php8-xmlreader \
	php8-xmlwriter \
	php8-xsl \
	php8-zip \
	php8-zlib \
	php-composer2 \
	git &&\
	zypper clean -a

# FFmpeg for video processing support (from Packman Essentials)
RUN zypper in -y ffmpeg &&\
	zypper clean -a

# Browscap database
RUN wget -nv https://browscap.org/stream?q=Lite_PHP_BrowsCapINI -O /usr/share/php/browscap.ini

# Environment
ENV PHP_DATE_TIMEZONE="Europe/Paris" \
	PHP_ENABLE_OPCACHE="1" \
	PHP_MAX_EXECUTION_TIME="3600" \
	PHP_MAX_INPUT_TIME="3600" \
	PHP_MAX_INPUT_VARS="1000" \
	PHP_MEMORY_LIMIT="4G" \
	PHP_POST_MAX_SIZE="4G" \
	PHP_UPLOAD_MAX_FILESIZE="4G"

# Files
COPY ./root /
RUN confd -onetime -backend env &&\
	chmod a+rw /etc/passwd /etc/group &&\
	chmod -R a+rwX /etc/php8 /var/lib/php8
