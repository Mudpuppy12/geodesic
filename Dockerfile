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


ENV LESS=R
ENV TERM=xterm-256color
ENV DIRENV_ENABLED=true
ENV GEODESIC_TF_PROMPT_ENABLED=true

ENV BANNER="DevOps Shell"

ENV AWS_REGION_ABBREVIATION_TYPE=fixed
ENV AWS_DEFAULT_REGION=us-east-1
ENV AWS_DEFAULT_SHORT_REGION=ue1


#1password cli

RUN curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" | tee /etc/apt/sources.list.d/1password.list
RUN mkdir -p /etc/debsig/policies/AC2D62742012EA22/
RUN curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
RUN mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
RUN curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg

# Install the packages

RUN apt-get update && apt-get install -y -u \
    atmos \
    1password-cli \
    yubikey-manager \
    ansible \
    python3-boto3
  
RUN rm /etc/motd

