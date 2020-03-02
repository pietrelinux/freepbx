apt-get update && apt-get upgrade -y 
apt-get install -y build-essential checkinstall libiksemel-dev libiksemel3 cmake openssh-server apache2 mariadb-server\
mariadb-client bison flex php php-curl php-cli php-pdo php-mysql php-pear php-gd php-mbstring php-intl\
curl sox libncurses5-dev libssl-dev mpg123 libxml2-dev odbcinst libnewt-dev libedit-dev sqlite3\
libsqlite3-dev pkg-config automake libtool autoconf git unixodbc-dev uuid uuid-dev\
libasound2-dev libogg-dev libvorbis-dev libicu-dev libcurl4-openssl-dev libical-dev libneon27-dev libsrtp0-dev\
libspandsp-dev sudo subversion libtool-bin python-dev unixodbc dirmngr sendmail-bin sendmail\
  
curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
sudo apt-get install -y nodejs
  
cd /usr/src/
 
git clone https://github.com/MariaDB/mariadb-connector-odbc.git
git clone https://github.com/MariaDB/mariadb-connector-c.git
cd mariadb-connector-c/
git checkout tags/v3.1.7
cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=/usr/local -LH
make
echo "MariaDB ODBC client library" | tee description-pak
checkinstall --nodoc --pkgname "mariadb-connector-client-library" --pkgversion "3.1.7" --provides "mariadb-connector-client-library" --requires "libssl1.0.2" --requires "mariadb-server" --maintainer "pietre.linux@gmail.com" --replaces none --conflicts none --install=no -y
sudo dpkg -i mariadb-connector-client-library_3.1.7-1_arm64.deb 
cd /usr/src/
cd mariadb-connector-odbc/
git checkout tags/3.0.1
cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DWITH_OPENSSL=true -DCMAKE_INSTALL_PREFIX=/usr/local -LH
make
make install
pear install Console_Getopt
cd /usr/src
wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-17.2.0.tar.gz
wget http://downloads.asterisk.org/pub/telephony/dahdi-linux-complete/dahdi-linux-complete-current.tar.gz
wget http://downloads.asterisk.org/pub/telephony/libpri/libpri-current.tar.gz

tar xvfz dahdi-linux-complete-current.tar.gz
tar xvfz libpri-current.tar.gz
tar xvfz asterisk-17.2.0.tar.gz asterisk-17.2.0

cd dahdi-linux-complete-3.1.0+3.1.0/
make all
make install
make config

cd /usr/src
cd dahdi-linux-complete-3.1.0+3.1.0/
make all
cd ..
cd libpri-1.6.0/
make
make install
cd /usr/src
tar xvfz asterisk-17.2.0.tar.gz asterisk-17.2.0
cd asterisk-17.2.0/
contrib/scripts/get_mp3_source.sh 
contrib/scripts/install_prereq install
./configure --with-pjproject-bundled --with-jansson-bundled
make menuselect.makeopts
menuselect/menuselect --enable app_macro --enable format_mp3 menuselect.makeopts
make
make install
make config
ldconfig
useradd -m asterisk
chown asterisk. /var/run/asterisk
chown -R asterisk. /etc/asterisk
chown -R asterisk. /var/{lib,log,spool}/asterisk
chown -R asterisk. /usr/lib/asterisk
rm -rf /var/www/html
sed -i 's/\(^upload_max_filesize = \).*/\120M/' /etc/php/7.0/apache2/php.ini
cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf_orig
sed -i 's/^\(User\|Group\).*/\1 asterisk/' /etc/apache2/apache2.conf
sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
a2enmod rewrite
service apache2 restart
cat <<EOF > /etc/odbcinst.ini
[MySQL]
  

