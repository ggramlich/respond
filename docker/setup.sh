# Install respond.

# Fail early
set -e

rm -fr /app
if [ -z "${RESPOND_TGZ_DOWNLOAD}" ]; then
  mkdir /app
  git clone --depth=1 -b ${RESPOND_BRANCH} ${RESPOND_REPO} /app
else
  cd /tmp
  wget -O app.tgz ${RESPOND_TGZ_DOWNLOAD}
  mkdir /tmp/apptgz
  # The tgz should contain exactly one directory on top level, but we do not know its name.
  # So we untar it to a temporary directory and mv the subfolder to /app
  tar xzf app.tgz -C /tmp/apptgz
  mv /tmp/apptgz/*/ /app
  rmdir /tmp/apptgz
  rm app.tgz
fi

mkdir /app/sites
# Check, if the setup.local.php.tmpl matches the original tmpl
# So for new versions of the setup.php, we get a broken docker build and can adjust the template accordingly
DB_USER="dbuser" DB_PASSWORD="dbpass" dockerize -delims "<%:%>" -template /setup.local.php.tmpl:/tmp/setup.local.php.test
if ! diff -q /tmp/setup.local.php.test /app/setup.php > /dev/null  2>&1; then
  echo "setup.local.php.tmpl does not match /app/setup.php"
  diff /tmp/setup.local.php.test /app/setup.php
  exit 1
fi
rm /tmp/setup.local.php.test


# Adjust the apache config
perl -p -i -e "s/AllowOverride FileInfo/AllowOverride All/" /etc/apache2/sites-available/000-default.conf 

#
# Lets make sure we `chown -R www-data  /app/sites` before starting up 
# as the use might point it to a different voluem
perl -p -i -e 's/exec supervisord -n/
chown -R www-data \/app\/sites 
exec supervisord -n/' /run.sh 
