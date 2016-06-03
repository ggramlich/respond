# Start from a Lamp container https://github.com/tutumcloud/lamp 
FROM tutum/lamp:latest

ARG RESPOND_REPO=https://github.com/madoublet/respond.git
ARG RESPOND_BRANCH=master
ARG RESPOND_TGZ_DOWNLOAD=""

RUN apt-get update && apt-get install -y wget

# Install dockerize for templating with setup.local.php.tmpl
ENV DOCKERIZE_VERSION v0.2.0
ENV DOCKERIZE_TGZ=dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/$DOCKERIZE_TGZ \
    && tar -C /usr/local/bin -xzvf $DOCKERIZE_TGZ

# Copy in the current dir as the respond app
COPY setup.sh /setup.sh
COPY mysql-setup.sh /mysql-setup.sh
ADD setup.local.php.tmpl /
ADD update-setup-local-php.sh /
RUN bash /setup.sh && rm /setup.sh

EXPOSE 80 3306
VOLUME ["/app/sites", "/var/lib/mysql"]
CMD ["/update-setup-local-php.sh && /run.sh"]
