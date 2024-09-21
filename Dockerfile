# We always recommend pinning versions to avoid surprises and breaking changes.
# We put the version up top here so it is easy to find and update.
# Find the latest version at https://github.com/cloudposse/geodesic/releases
ARG VERSION=3.0.0
# If you don't want to bothered with updating the version, you can use `latest` instead,
# but keep in mind that as long as you have a local image with the `latest` tag,
# it will not be updated by `docker run`. You will have to explicitly pull the latest image.
# ARG VERSION=latest
ARG OS=debian
FROM cloudposse/geodesic:$VERSION-$OS

# Add configuration options such as setting a custom BANNER,
# setting the initial AWS_PROFILE and AWS_DEFAULT_REGION, etc. here

ENV DOCKER_IMAGE="mudpuppy12/devops"
ENV DOCKER_TAG="latest"

ENV MOTD_URL=""

ENV LESS=R
ENV TERM=xterm-256color
ENV DIRENV_ENABLED=true
ENV GEODESIC_TF_PROMPT_ENABLED=true

ENV BANNER="DevOps Shell"

ENV AWS_REGION_ABBREVIATION_TYPE=fixed
ENV AWS_DEFAULT_REGION=us-east-1
ENV AWS_DEFAULT_SHORT_REGION=ue1

# Install the packages

RUN apt-get update && apt-get install -y -u \
    atmos \
    ansible \
    python3-boto3
  
RUN rm /etc/motd

