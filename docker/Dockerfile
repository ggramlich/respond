# Start from a Lamp container https://github.com/tutumcloud/lamp 
FROM tutum/lamp:latest

RUN apt-get update && apt-get install -y wget

# You can override the following ARG with --build-arg on the docker build
# (requires docker >=v1.9)
ARG RESPOND_REPO=https://github.com/madoublet/respond.git
ARG RESPOND_BRANCH=master

# If you set the following to the URL of a release tar.gz, this will be downloaded
# instead of cloning the git repository
# e.g. --build-arg RESPOND_TGZ_DOWNLOAD=="https://github.com/madoublet/respond/archive/4.6.tar.gz"
ARG RESPOND_TGZ_DOWNLOAD=""

# Install dockerize for templating with setup.local.php.tmpl
ENV CPU_ARCH=amd64
ENV DOCKERIZE_VERSION v0.2.0
ENV DOCKERIZE_TGZ=dockerize-linux-$CPU_ARCH-$DOCKERIZE_VERSION.tar.gz
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/$DOCKERIZE_TGZ \
    && tar -C /usr/local/bin -xzvf $DOCKERIZE_TGZ

# Copy setup files to the root directory
ADD setup.sh /
ADD mysql-setup.sh /
ADD setup.local.php.tmpl /
ADD update-templates-and-run.sh /
RUN bash /setup.sh && rm /setup.sh

EXPOSE 80 3306
VOLUME ["/app/sites", "/var/lib/mysql"]
CMD ["/update-templates-and-run.sh"]
