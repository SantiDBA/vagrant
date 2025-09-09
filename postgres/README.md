# Vagrant PostgreSQL Environment

This project provides a simple Vagrant environment for provisioning a PostgreSQL database on an Oracle Linux 8 VM.

## Prerequisites

*   [Vagrant](https://www.vagrantup.com/downloads)
*   [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

## Getting Started

1.  Clone this repository.
2.  Navigate to the project directory.
3.  Run `vagrant up` to provision the virtual machine.

## Configuration

The Vagrant environment can be configured by modifying the following files:

*   `config/vagrant.yml`: This file contains the main configuration for the Vagrant VM, such as the box, memory, CPUs, and IP address. You can also select the PostgreSQL version to install by changing the `pg_version` parameter. Available versions are: 13, 14, 15, and 16.
*   `config/install.env`: This file contains environment variables for the installation scripts. Set `INSTALL_POSTGRES` to `true` to install PostgreSQL.

## Connecting to the Database

Once the VM is provisioned, you can connect to the PostgreSQL database using the following credentials:

*   **Host**: `192.168.56.140` (or the IP address specified in `config/vagrant.yml`)
*   **Port**: `5432`
*   **User**: `postgres`
*   **Password**: (not set by default)

You can connect to the VM using `vagrant ssh`. The PostgreSQL binaries are located in `/usr/pgsql-<version>/bin`.

## Destroying the Environment

To destroy the virtual machine, run `vagrant destroy`.
