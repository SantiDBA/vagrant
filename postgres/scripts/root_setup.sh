#!/bin/bash
. /vagrant/config/install.env



## Postgres packages
sh /vagrant/scripts/install_os_packages.sh

## Postgres Setup
#su - postgres -c 'sh /vagrant/scripts/setup_postgres.sh'
sh /vagrant/scripts/setup_postgres.sh


echo "******************************************************************************"
echo "** Your virtual environment is ready now.                                     "
echo "** You can find RDBMS software and scripts available on /vagrant directory.   "
echo "**                                                                            "
echo "** ENJOY IT!                                                                  "
echo "**                                                                            "
echo "** Installation ended at: " `date`
echo "******************************************************************************"
