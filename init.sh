#!/usr/bin/env bash

# OS=$(cat /etc/*release)
# echo OS > $OS|grep ID

echo "Ingress Software to Install "

cat << EOF
Ingress the Software # to install :
1. Postgres
2. Python
3. all
EOF
read software
echo Software to install: $software

cat << EOF
Ingress the Software # to install :
1. Package Manager
2. Source Code
EOF
read installation_type

echo Type of installation: $installation_type


if [ $installation_type = 1 ] 
then
# echo "installation folder : $"
folderInst=./centos8/pckmanager
else
folderInst=./centos8/source
fi


if [ $software = 1 ] 
then
sw2inst="postgres12"
elif [ $software = 2 ]
then
sw2inst="postgres12"
else
echo $software nothing
fi


sudo yum update -y
sudo yum install git -y
sudo git clone https://github.com/johannesanchez/linux-common-scripts.git



cd $folderInst
echo sudo sh ./$sw2inst"-install.sh"