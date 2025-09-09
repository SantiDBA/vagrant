#!/bin/bash
. /vagrant/config/install.env

echo "******************************************************************************"
echo "Prepare yum with the latest repos." `date`
echo "******************************************************************************"
echo "nameserver 8.8.8.8" >> /etc/resolv.conf

dnf install -y dnf-utils zip unzip

echo "******************************************************************************"
echo " Download Postgres 16." `date`
echo "******************************************************************************"
dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
dnf -qy module disable postgresql

dnf install -y postgresql${PGVERSION}-server

/usr/pgsql-${PGVERSION}/bin/postgresql-${PGVERSION}-setup initdb
sudo systemctl daemon-reload

sudo sed -i "s/^#listen_addresses = 'localhost'/listen_addresses = '*'/g" \
    /var/lib/pgsql/${PGVERSION}/data/postgresql.conf

echo "host    all             all             samenet           scram-sha-256" \
    | sudo tee -a /var/lib/pgsql/${PGVERSION}/data/pg_hba.conf

systemctl enable postgresql-${PGVERSION}
systemctl start postgresql-${PGVERSION}

sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'postgres';"

echo "******************************************************************************"
echo "Firewall." `date`
echo "******************************************************************************"
sudo systemctl stop firewalld
sudo systemctl disable firewalld

echo "******************************************************************************"
echo "SELinux." `date`
echo "******************************************************************************"
sed -i -e "s|SELINUX=enabled|SELINUX=permissive|g" /etc/selinux/config
sudo setenforce permissive