FROM centos:latest
RUN yum update -y && \
    yum install -y wget epel-release && \
    wget http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm && \
    yum update -y && \
    rpm -ivh nux-dextop-release-0-5.el7.nux.noarch.rpm && \
    yum -y install minidlna deluge-web && \
    yum clean all && \
    mkdir -p /home/Videos && \
    easy_install flexget

COPY ["config.yml", "templates/", "/root/.flexget/"]
COPY ["startup.sh", "/root/"]
COPY ["minidlna.conf", "/etc/"]

VOLUME ["/home/"]
EXPOSE 8112 8200 1900

ENTRYPOINT ["/root/startup.sh"]
