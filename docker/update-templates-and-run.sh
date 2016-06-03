#!/bin/bash

dockerize -delims "<%:%>" -template /setup.local.php.tmpl:/app/setup.local.php

function create_site_conf {
  export SITE_NAME=$1
  export SITE_DOMAIN=$2
  if [ -n "${SITE_NAME}" ]; then
    dockerize -delims "<%:%>" -template /respond-virtualhost.conf.tpl:/etc/apache2/sites-available/${SITE_DOMAIN}.conf
    a2ensite ${SITE_DOMAIN}
  fi
}

#http://stackoverflow.com/questions/10586153/split-string-into-an-array-in-bash
IFS=',' read -r -a sites <<< "$VIRTUAL_HOST_RESPOND_SITES"
IFS=',' read -r -a domains <<< "$VIRTUAL_HOST"

for index in "${!sites[@]}"
do
  create_site_conf "${sites[index]}" "${domains[index]}"
done

/run.sh
