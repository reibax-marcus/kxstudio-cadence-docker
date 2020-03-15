FROM  debian:buster-20200224

# Install standard available packages
RUN apt update && apt install -y wget procps

RUN wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_10.0.3_all.deb

# Install required dependencies if needed
RUN apt-get install -y apt-transport-https gpgv

# Remove legacy repos
RUN dpkg --purge kxstudio-repos-gcc5

# Download package file
RUN wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_10.0.3_all.deb

# Install it
RUN dpkg -i kxstudio-repos_10.0.3_all.deb

RUN apt update

RUN apt install -y cadence

COPY --chown=0:0 files/etc/passwd /etc/passwd
COPY --chown=0:0 files/etc/shadow /etc/shadow
COPY --chown=0:0 files/etc/group /etc/group
COPY --chown=1000:1000 files/home/docker /home/docker

CMD [ "/usr/bin/cadence" ]