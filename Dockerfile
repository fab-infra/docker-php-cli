# PHP based on openSUSE 15.6
FROM ghcr.io/fab-infra/base-image:opensuse15.6

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
	php8-imagick \
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
	php8-tidy \
	php8-tokenizer \
	php8-xmlreader \
	php8-xmlwriter \
	php8-xsl \
	php8-zip \
	php8-zlib \
	php8-APCu \
	git &&\
	zypper clean -a

# Composer
RUN zypper ar -cfp 90 https://download.opensuse.org/repositories/server:/php:/applications/15.6/ server:php:applications &&\
	zypper --gpg-auto-import-keys ref &&\
	zypper in -y php-composer2 &&\
	zypper clean -a

# FFmpeg for video processing support (from Packman Essentials)
RUN zypper ar -cfp 90 http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_15.6/Essentials packman-essentials &&\
	zypper --gpg-auto-import-keys ref &&\
	zypper in -y ffmpeg &&\
	zypper clean -a

# Browscap database
RUN wget -nv https://browscap.org/stream?q=Lite_PHP_BrowsCapINI -O /usr/share/php/browscap.ini

# Files
COPY ./root /
RUN chmod a+rw /etc/passwd /etc/group &&\
	chmod -R a+rwX /var/lib/php8
