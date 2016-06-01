# Install respond.
rm -fr /app; mkdir /app; cd /app
git clone --depth=1 -b ${RESPOND_BRANCH} ${RESPOND_REPO} .
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
