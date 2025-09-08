#!/bin/bash
. /vagrant/config/install_options.env

echo "******************************************************************************"
echo "Prepare yum with the latest repos." `date`
echo "******************************************************************************"
echo "nameserver 8.8.8.8" >> /etc/resolv.conf

dnf install -y dnf-utils zip unzip



echo "******************************************************************************"
echo " Download Postgres 15." `date`
echo "******************************************************************************"
dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
dnf -qy module disable postgresql

    dnf install -y postgresql15-server
    
    /usr/pgsql-15/bin/postgresql-15-setup initdb
    sudo systemctl daemon-reload
    sudo sed -i "s/^#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/pgsql/15/data/postgresql.conf
    echo "host    all             all             samenet           scram-sha-256" >> /var/lib/pgsql/15/data/pg_hba.conf
    systemctl enable postgresql-15
    systemctl start postgresql-15
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