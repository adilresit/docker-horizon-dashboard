
FROM ubuntu:12.04
MAINTAINER adilresitdursun <ardursun@konya.edu.tr>
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y   apache2 memcached libapache2-mod-wsgi openstack-dashboard
RUN apt-get install -y openssh-server 

RUN mkdir /var/run/sshd
RUN echo 'root:123' |chpasswd
RUN echo 'PermitRootLogin yes' > /etc/ssh/sshd_config  

RUN apt-get install -y python-memcache python-django-nova 
RUN apt-get install -y supervisor
RUN rm -rf /var/lib/apt/lists/* 
RUN apt-get remove -y openstack-dashboard-ubuntu-theme

ADD supervisord.conf supervisord.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 22
EXPOSE 80
EXPOSE 11211

VOLUME ["/etc/supervisor/conf.d"]
WORKDIR /etc/supervisor/conf.d
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]

