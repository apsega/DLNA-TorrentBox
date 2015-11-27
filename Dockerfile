FROM centos:latest
RUN yum -y install wget epel-release && \
    wget http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm && \
    yum update -y && \
    rpm -ivh nux-dextop-release-0-5.el7.nux.noarch.rpm && \
    yum -y install minidlna deluge-web && \
    yum clean all && \
    easy_install flexget
#    (crontab -l ; echo "@hourly /usr/bin/flexget execute -v >> /var/log/flexget.log 2>&1") 2>&1 | grep -v "no crontab" | crontab - && \

ADD config.yml /root/.flexget/

COPY startup.sh /home/

EXPOSE 8112 8200 1900/udp

ENTRYPOINT ["/home/startup.sh"]
