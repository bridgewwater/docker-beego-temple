# This dockerfile uses the golang image
# https://hub.docker.com/_/golang/
# VERSION 1
# Author: sinlov
# Command format: Instruction [arguments / command]

FROM golang:1.10.3-alpine

MAINTAINER  sinlov sinlovgmppt@gmail.com

ADD ./src/github.com /go/src/github.com
ADD ./build.sh /build.sh

RUN chmod +x /build.sh \
  && /build.sh

# EXPOSE  80

# ENTRYPOINT ["tail", "-F", "/var/log/faillog"]
# CMD ["-F", "/var/log/faillog"]

# ENV

# ADD

# COPY

# ENTRYPOINT

# VOLUME

# USER

# WORKDIR

# ONBUILD