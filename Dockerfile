FROM centos

LABEL maintainer='itakum <uv1015takumi@gmail.com>'

RUN /bin/cp -f /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN yum install -y gcc ruby python
