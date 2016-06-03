<VirtualHost *:80>
  ServerName <% .Env.SITE_DOMAIN %>
  ServerAlias <% .Env.SITE_DOMAIN %>

  ServerAdmin <% default .Env.ADMIN_EMAIL "sample@adminemail.com" %>
  DocumentRoot /var/www/html/sites/<% .Env.SITE_NAME %>/

  <Directory /var/www/html/sites/<% .Env.SITE_NAME %>>
    Options Indexes FollowSymLinks MultiViews
    # To make wordpress .htaccess work
    AllowOverride All
    Order allow,deny
    allow from all
  </Directory>

</VirtualHost>
