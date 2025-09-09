#!/bin/bash
. /vagrant/config/install.env

## Postgres packages
sh /vagrant/scripts/install_os_packages.sh

echo "******************************************************************************"
echo "** Your PG $PGVERSION environment is ready now.                               "
echo "**                                                                            "
echo "** ENJOY IT!                                                                  "
echo "**                                                                            "
echo "** Installation ended at: " `date`
echo "**                                                                            "
echo "** Connect by: psql -h 192.168.56.140 -p 5432 -U postgres -d postgres"
echo "**                                                                            "
echo "******************************************************************************"
