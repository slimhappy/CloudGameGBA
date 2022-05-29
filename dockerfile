FROM centos:8
RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum -y install epel-release
RUN dnf -y install Xvfb
RUN dnf -y install x11vnc net-tools
RUN dnf -y install wget 
RUN dnf -y install gcc
RUN dnf -y install gcc-c++
RUN dnf -y install zlib zlib-devel
RUN dnf --enablerepo=powertools -y install flac-devel
RUN dnf --enablerepo=powertools -y install SDL2-devel
RUN dnf -y install make
RUN cd /home/
RUN wget https://mednafen.github.io/releases/files/mednafen-1.29.0.tar.xz
RUN tar -xf mednafen-1.29.0.tar.xz
RUN cd /home/mednafen/
RUN ./configure && make && make install
RUN Xvfb -ac -screen scrn 800x800x24 :9.0 &
ENV DISPLAY :9.0
RUN x11vnc -listen 0.0.0.0 -rfbport 5900 -noipv6 -passwd 970218 -display :9.0 &
