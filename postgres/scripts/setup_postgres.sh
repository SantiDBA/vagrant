dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
dnf -qy module disable postgresql

# Check the boolean variable
if [[ "${INSTALL_POSTGRES,,}" == 'true' ]]; then
    dnf install -y postgresql15-server
    echo "export PATH=\$PATH:/usr/pgsql-15/bin" > /var/lib/pgsql/.pgsql_profile
    /usr/pgsql-15/bin/postgresql-15-setup initdb
    echo "listen_addresses = '*'" >> /var/lib/pgsql/15/data/postgresql.conf
    echo "host    all             all             samenet           scram-sha-256" >> /var/lib/pgsql/15/data/pg_hba.conf
    systemctl enable postgresql-15
    systemctl start postgresql-15
fi