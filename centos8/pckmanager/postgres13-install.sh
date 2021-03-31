#!/usr/bin/env bash
# Upgrade all installed packages
sudo yum update -y

# #create the installation folder and download the repo
# sudo mkdir ./install
# cd ./install
# sudo git clone https://github.com/johannesanchez/linux-common-scripts.git


# Disable Buil-tin PostgreSQL module
sudo dnf -qy module disable postgresql

# Enable the official PostgreSQL Yum Repository
sudo dnf install https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm -y

# Install the PostgreSQL 12 server and client packages
dnf install postgresql12 postgresql12-server -y

# initialize the PostgreSQL database, then start the PostgreSQL-12 service and enable it to automatically start at system boot
sudo /usr/pgsql-13/bin/postgresql-13-setup initdb
sudo systemctl start postgresql-13
sudo systemctl enable --now postgresql-13
echo $(systemctl status postgresql-13)
systemctl is-enabled postgresql-12

# su - postgres
# psql
# \l
# \du
# alter user postgres password 'admin@192837465'
# Secure the Postgres user account and the database administrative user account
# passwd postgres


# Hardening
# sudo vi /var/lib/pgsql/13/data/pg_hba.conf
# # Accept from anywhere (not recommended)
# host all all 0.0.0.0/0 md5

# # Accept from trusted subnet (Recommended setting)
# host all all 192.168.18.0/24 md5
# sudo systemctl restart postgresql-13

