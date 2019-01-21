# This dockerfile uses the golang image
# https://hub.docker.com/_/golang/
# VERSION 1
# Author: sinlov
# Command format: Instruction [arguments / command]

FROM sinlov/bee:1.9.1

MAINTAINER  sinlov sinlovgmppt@gmail.com

ADD ./src/git.sinlov.com/api-sso/api-sso-base/ /go/src/git.sinlov.com/api-sso/api-sso-base/
ADD ./src/github.com/astaxie/beego/ /go/src/github.com/astaxie/beego/
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