apt-get update && apt-get upgrade -y 
apt-get install -y build-essential linux-headers-`uname -r` openssh-server apache2 mariadb-server\
  mariadb-client bison flex php php-curl php-cli php-pdo php-mysql php-pear php-gd php-mbstring php-intl\
  curl sox libncurses5-dev libssl-dev mpg123 libxml2-dev libnewt-dev sqlite3\
  libsqlite3-dev pkg-config automake libtool autoconf git unixodbc-dev uuid uuid-dev\
  libasound2-dev libogg-dev libvorbis-dev libicu-dev libcurl4-openssl-dev libical-dev libneon27-dev libsrtp0-dev\
  libspandsp-dev sudo subversion libtool-bin python-dev unixodbc dirmngr sendmail-bin sendmail\
  
  curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
  sudo apt-get install -y nodejs
  
  cd /usr/src/
