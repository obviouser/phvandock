# Base Vagrant box

FROM debian:jessie


#install required packages

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y python-apt apt-utils cron openssh-server sudo net-tools wget curl locales dialog && apt-get clean 

# Create and configure vagrant user
RUN useradd --create-home -s /bin/bash vagrant
WORKDIR /home/vagrant
RUN usermod -a -G vagrant root
# Configure SSH access
RUN mkdir -p /home/vagrant/.ssh && \
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" > /home/vagrant/.ssh/authorized_keys && \
    chown -R vagrant: /home/vagrant/.ssh && \
    adduser vagrant sudo && \
    `# Enable passwordless sudo for users under the "sudo" group` && \
    sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers && \
    echo -n 'vagrant:vagrant' | chpasswd && \
    `# Thanks to http://docs.docker.io/en/latest/examples/running_ssh_service/` && \
    mkdir /var/run/sshd

# Expose ports
EXPOSE 22
EXPOSE 80
EXPOSE 443
EXPOSE 3306
EXPOSE 9000
#leave the SHH daemon (and container) running
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
CMD sudo /usr/sbin/locale-gen
CMD /usr/sbin/sshd -D
