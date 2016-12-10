FROM orboan/dcss-shellinabox-httpd
MAINTAINER Oriol Boix Anfosso <dev@orboan.com>

RUN yum update

RUN \ 
rpm -Uvh --replacepkgs https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN \
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

RUN yum install -y php56w php56w-opcache php56w-mysql php56w-iconv php56w-mbstring php56w-curl php56w-openssl php56w-tokenizer php56w-soap php56w-ctype php56w-zip php56w-gd php56w-simplexml php56w-spl php56w-pcre php56w-dom php56w-xml php56w-intl php56w-json php56w-ldap php56w-pecl-apcu php56w-odbc php56w-pear php56w-xmlrpc php56w-snmp php56w-pdo curl

RUN yum install -y ghostscript

RUN \ 
cd /var/www/html && \
wget https://wordpress.org/latest.tar.gz && \
tar -xvf latest.tar.gz && \
rm -f latest.tar.gz && \
mv /var/www/html/wordpress /var/www/html/wp && \
chown -R apache:apache /var/www/html/wp && \
chmod -R 755 /var/www/html/wp

# - Clean YUM caches to minimise Docker image size...
RUN \
  yum clean all && rm -rf /tmp/yum*

# default
ENV MYSQL_HOST=mysql
ENV MYSQL_DATABASE=wp
ENV MYSQL_USER=wp_user
ENV MYSQL_PASSWORD=iaw
ENV WP_URL=http://iaw.io/wp

ADD container-files /
