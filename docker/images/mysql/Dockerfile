FROM mariadb:latest

RUN apt-get update ;\
    apt-get install -y pv gettext ;\
    apt-get clean autoclean ;\
    apt-get autoremove --yes ;\
    rm -rf /var/lib/{apt,dpkg,cache,log}/ ;\
    rm -rf /tmp/*; \
    apt-get --no-install-recommends --no-install-suggests -y install expect
COPY mysql/my.cnf /etc/my.cnf
COPY mysql/my.cnf /etc/mysql/my.cnf
