# Start from a Lamp container https://github.com/tutumcloud/lamp 
FROM tutum/lamp:latest

ARG RESPOND_REPO=https://github.com/madoublet/respond.git
ARG RESPOND_BRANCH=master
ARG RESPOND_TGZ_DOWNLOAD=""

# Copy in the current dir as the respond app
COPY setup.sh /setup.sh
COPY mysql-setup.sh /mysql-setup.sh
RUN bash /setup.sh; rm /setup.sh

EXPOSE 80 3306
VOLUME ["/app/sites", "/var/lib/mysql"]
CMD ["/run.sh"]
