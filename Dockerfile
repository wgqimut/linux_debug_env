FROM ubuntu:16.04
MAINTAINER Grady Wong

RUN apt update && \
    apt install -y openssh-server gdb gdbserver sudo build-essential git && \
    mkdir /var/run/sshd && \
    echo 'root:root' | chpasswd && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_logiuid.so@g' -i /etc/pam.d/sshd && \
    apt clean

VOLUME /usr/src
WORKDIR /usr/src

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]