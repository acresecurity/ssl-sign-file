# Container image that runs your code
FROM ubuntu:latest

RUN apt-get -qq update  > /dev/null
RUN apt-get install -y -qq default-jre > /dev/null
RUN apt-get -y -qq install curl > /dev/null
RUN apt-get install -y -qq unzip > /dev/null

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]