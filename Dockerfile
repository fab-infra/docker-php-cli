# PHP based on openSUSE 15.3
FROM ghcr.io/fab-infra/base-image:opensuse15.3

# PHP with modules
RUN zypper in -y php7 php7-devel \
	php7-bcmath \
	php7-bz2 \
	php7-ctype \
	php7-curl \
	php7-dom \
	php7-exif \
	php7-fileinfo \
	php7-ftp \
	php7-gd \
	php7-gettext \
	php7-gmp \
	php7-iconv \
	php7-imagick \
	php7-intl \
	php7-json \
	php7-ldap \
	php7-mbstring \
	php7-memcached \
	php7-mysql \
	php7-opcache \
	php7-openssl \
	php7-pcntl \
	php7-pdo \
	php7-phar \
	php7-posix \
	php7-redis \
	php7-soap \
	php7-tidy \
	php7-tokenizer \
	php7-xmlreader \
	php7-xmlrpc \
	php7-xmlwriter \
	php7-xsl \
	php7-zip \
	php7-zlib \
	php7-APCu \
	git &&\
	zypper clean -a

# Composer
RUN zypper ar -cfp 90 https://download.opensuse.org/repositories/server:/php:/applications/openSUSE_Leap_15.3/ server:php:applications &&\
	zypper --gpg-auto-import-keys ref &&\
	zypper in -y php-composer2 &&\
	zypper clean -a

# FFmpeg for video processing support (from Packman Essentials)
RUN zypper ar -cfp 90 http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_15.3/Essentials packman-essentials &&\
	zypper --gpg-auto-import-keys ref &&\
	zypper in -y ffmpeg &&\
	zypper clean -a

# Browscap database
RUN wget -nv https://browscap.org/stream?q=Lite_PHP_BrowsCapINI -O /usr/share/php7/browscap.ini

# Files
COPY ./root /
RUN chmod a+rw /etc/passwd /etc/group &&\
	chmod -R a+rwX /var/lib/php7
