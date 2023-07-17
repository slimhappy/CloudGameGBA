# 使用CentOS 8作为基础镜像
FROM centos:8

# 切换到yum源目录
RUN cd /etc/yum.repos.d/

# 注释掉mirrorlist，使用baseurl
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*

# 修改baseurl为vault.centos.org
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# 安装epel-release
RUN yum -y install epel-release

# 安装Xvfb
RUN dnf -y install Xvfb

# 安装x11vnc和net-tools
RUN dnf -y install x11vnc net-tools

# 安装wget
RUN dnf -y install wget 

# 安装gcc
RUN dnf -y install gcc

# 安装gcc-c++
RUN dnf -y install gcc-c++

# 安装zlib和zlib-devel
RUN dnf -y install zlib zlib-devel

# 安装flac-devel
RUN dnf --enablerepo=powertools -y install flac-devel

# 安装SDL2-devel
RUN dnf --enablerepo=powertools -y install SDL2-devel

# 安装make
RUN dnf -y install make

# 切换到/home目录
RUN cd /home/

# 下载mednafen-1.29.0.tar.xz
RUN wget https://mednafen.github.io/releases/files/mednafen-1.29.0.tar.xz

# 解压mednafen-1.29.0.tar.xz
RUN tar -xf mednafen-1.29.0.tar.xz

# 切换到/home/mednafen目录
RUN cd /home/mednafen/

# 配置、编译和安装mednafen
RUN ./configure && make && make install

# 启动Xvfb
RUN Xvfb -ac -screen scrn 800x800x24 :9.0 &

# 设置DISPLAY环境变量
ENV DISPLAY :9.0

# 启动x11vnc
RUN x11vnc -listen 0.0.0.0 -rfbport 5900 -noipv6 -passwd 970218 -display :9.0 &
