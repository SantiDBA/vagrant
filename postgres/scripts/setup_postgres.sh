dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
dnf -qy module disable postgresql

# Check the boolean variable
if [[ "${INSTALL_POSTGRES,,}" == 'true' ]]; then
    dnf install -y postgresql${PG_VERSION}-server
    echo "export PATH=\$PATH:/usr/pgsql-${PG_VERSION}/bin" > /var/lib/pgsql/.pgsql_profile
    /usr/pgsql-${PG_VERSION}/bin/postgresql-${PG_VERSION}-setup initdb
    echo "listen_addresses = '*'" >> /var/lib/pgsql/${PG_VERSION}/data/postgresql.conf
    echo "host    all             all             samenet           scram-sha-256" >> /var/lib/pgsql/${PG_VERSION}/data/pg_hba.conf
    systemctl enable postgresql-${PG_VERSION}
    systemctl start postgresql-${PG_VERSION}
fi