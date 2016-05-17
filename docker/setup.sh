# Install respond.
rm -fr /app
if [ -z "${RESPOND_TGZ_DOWNLOAD}" ]; then
  mkdir /app
  git clone --depth=1 -b ${RESPOND_BRANCH} ${RESPOND_REPO} /app
else
  apt-get -y install wget
  cd /tmp
  wget -O app.tgz ${RESPOND_TGZ_DOWNLOAD}
  mkdir /tmp/apptgz
  # The zip should contain exactly one directory on top level, but we do not know its name.
  # So we unzip it to a temporary directory and mv the subfolder to /app
  tar xzf app.tgz -C /tmp/apptgz
  mv /tmp/apptgz/*/ /app
  rmdir /tmp/apptgz
  rm app.tgz
fi

mkdir /app/sites
cat /app/setup.php | sed s/dbuser/root/ | sed s/dbpass// > /app/setup.local.php

# Adjust the apache config
perl -p -i -e "s/AllowOverride FileInfo/AllowOverride All/" /etc/apache2/sites-available/000-default.conf 

#
# Lets make sure we `chown -R www-data  /app/sites` before starting up 
# as the use might point it to a different voluem
perl -p -i -e 's/exec supervisord -n/
chown -R www-data \/app\/sites 
exec supervisord -n/' /run.sh 
