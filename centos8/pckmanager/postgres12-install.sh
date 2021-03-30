#!/usr/bin/env bash
# Upgrade all installed packages
sudo yum update -y

# Install git
sudo yum install git -y

# Install 

# Disable Buil-tin PostgreSQL module
dnf -qy module disable postgresql

# Enable the official PostgreSQL Yum Repository
dnf install https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm -y

# Install the PostgreSQL 12 server and client packages
dnf install postgresql12 postgresql12-server -y

# initialize the PostgreSQL database, then start the PostgreSQL-12 service and enable it to automatically start at system boot
/usr/pgsql-12/bin/postgresql-12-setup initdb 
systemctl start postgresql-12
systemctl enable postgresql-12
echo $(systemctl status postgresql-12)
systemctl is-enabled postgresql-12


# Secure the Postgres user account and the database administrative user account
# passwd postgres

