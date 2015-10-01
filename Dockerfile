FROM ubuntu:latest
RUN sudo apt-get -y --fix-missing install apache2 libapache2-mod-php5 php5-curl php5-sqlite wget \
	&& cd /opt \
	&& wget http://www.zend.com/en/download/3458?start=true -O /tmp/zray.tar.gz \
	&& sudo tar xvfz /tmp/zray.tar.gz -C /opt \
	&& sudo cp /opt/zray/zray-ui.conf /etc/apache2/sites-available \
	&& sudo a2ensite zray-ui.conf \
	&& sudo a2enmod rewrite \
	&& sudo ln -sf /opt/zray/zray.ini /etc/php5/apache2/conf.d/zray.ini \
	&& sudo ln -sf /opt/zray/zray.ini /etc/php5/cli/conf.d/zray.ini \
	&& sudo ln -sf /opt/zray/lib/zray.so /usr/lib/php5/20121212/zray.so \
	&& sudo chown -R www-data:www-data /opt/zray \
	&& sudo a2enmod headers \
	&& sudo a2enmod rewrite \
	&& sudo service apache2 restart

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR

VOLUME [ "/var/www/html" ]
WORKDIR /var/www/html

#EXPOSE 80
EXPOSE 10081

ENTRYPOINT [ "/usr/sbin/apache2" ]
CMD ["-D", "FOREGROUND"]