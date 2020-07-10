FROM centos:7
RUN yum update -y && \
    yum install -y wget epel-release && \
    wget http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm && \
    yum update -y && \
    rpm -ivh nux-dextop-release-0-5.el7.nux.noarch.rpm && \
    yum -y install minidlna deluge-web && \
    yum -y install python-pip && \
    pip install --upgrade pip --no-cache-dir && \
    pip install setuptools --upgrade --no-cache-dir && \
    yum clean all && \
    mkdir -p /home/Videos && \
    pip install flexget && \
    rm -rfv nux-dextop-release-0-5.el7.nux.noarch.rpm && \
    mkdir -p /home/Videos/Movies && \
    mkdir -p /home/Videos/TV_Shows

COPY ["config.yml", "templates/", "/root/.flexget/"]
COPY ["startup.sh", "/root/"]
COPY ["minidlna.conf", "/etc/"]

VOLUME ["/home/"]
EXPOSE 8112 8200 1900/udp

ENTRYPOINT ["/root/startup.sh"]
