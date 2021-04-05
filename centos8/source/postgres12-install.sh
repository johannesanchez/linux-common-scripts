#!/usr/bin/env bash

# RUN NEXT COMMANDS AS ROOT USER
# Create postgres user
# sudo useradd postgres && sudo passwd postgres

# Grants for postgres user
# sudo visudo
# postgres    ALL=(ALL)      ALL

# Switch to postgres user
# su - postgres

# RUN NEXT COMMANDS AS postgres USER

# Folder Locations
LOG_FOLDER=/postgres/logs
DATA_FOLDER=/postgres/data/postgres
BIN_FOLDER=/postgres/bin

# Upgrade all installed packages (optional)
# yum update -y

# Install necessary packages
sudo yum install wget gcc make bzip2 -y

# For extreme amount of activity
sudo mkdir /postgres && sudo chown postgres. -R /postgres
mkdir  $BIN_FOLDER && \
mkdir  $LOG_FOLDER && \
mkdir -p  $DATA_FOLDER && \
# mkdir postgres_backup && \
# mkdir postgres_temp

cd $BIN_FOLDER && \
wget https://ftp.postgresql.org/pub/source/v12.3/postgresql-12.3.tar.bz2  && \
chown postgres. postgresql-12.3.tar.bz2  && \
chmod 775 postgresql-12.3.tar.bz2 


mkdir postgresql-12.3-installers && \
tar -xvf postgresql-12.3.tar.bz2 && \
./postgresql-12.3/configure --prefix $BIN_FOLDER/postgresql-12.3-installers --without-readline --without-zlib  && \
make  && make install



cat >> ~/.bashrc <<EOL 
export PATH=${BIN_FOLDER}/postgresql-12.3-installers/bin:$PATH
export PGDATA=${DATA_FOLDER}
export PGUSER=postgres
export PGPORT=5432 #Hardening: your choise if you want to change the default port
export LOG_FOLDER=/postgres/logs
export DATA_FOLDER=/postgres/data/postgres
export BIN_FOLDER=/postgres/bin
EOL

source ~/.bashrc


#run postgres for the first time
cd $BIN_FOLDER/postgresql-12.3-installers && \
./bin/initdb -D $DATA_FOLDER -U postgres  && \
# ./bin/pg_ctl -D /databases/postgres/postgres_data -l /databases/postgres/postgres_logs/12.3_postgres_logfile.log -o "-p 5432" start
$BIN_FOLDER/postgresql-12.3-installers/bin/pg_ctl -D $DATA_FOLDER/ -l $LOG_FOLDER/12.3_postgres_logfile.log -o "-p 5432" start


#adding start postgres at boot
# original permissions:644
# /etc/rc.d/rc.local
sudo chmod 777 /etc/rc.d/rc.local
sudo echo 'sudo -u postgres /postgres/bin/postgresql-12.3-installers/bin/pg_ctl -D /postgres/data/postgres -l /postgres/logs/12.3_postgres_logfile.log -o "-p 5432" start' >> /etc/rc.local


###############################################################
# POST INSTALLATION STEPS
# Changing the default password for postgres user
# psql -c "alter user postgres with password 'thepasswordhere'"



# Accepting external connections. Please change it under your responsibility.
# Edit /postgres/data/postgres/postgresql.conf

# Before:
#listen_addresses = 'localhost'		# what IP address(es) to listen on;

# After:
#listen_addresses = '*'		# what IP address(es) to listen on;

# Edit /postgres/data/postgres/postgresql.conf

# Before: 
# "local" is for Unix domain socket connections only
# local   all             all                                     trust

# After:
# "local" is for Unix domain socket connections only
# local   all             all                                     trust
# host    all             all         0.0.0.0/0                   md5

# restart postgres instance:
# /postgres/bin/postgresql-12.3-installers/bin/pg_ctl -D /postgres/data/postgres -l /postgres/logs/12.3_postgres_logfile.log -o "-p 5432" stop
# /postgres/bin/postgresql-12.3-installers/bin/pg_ctl -D /postgres/data/postgres -l /postgres/logs/12.3_postgres_logfile.log -o "-p 5432" start


# #test the connection
# psql
# select version();
# show port;