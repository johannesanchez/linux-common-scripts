#!/bin/bash

# OS=$(cat /etc/*release)
# echo OS > $OS|grep ID

echo "Ingress Software to Install "

cat << EOF
Ingress the Software # to install :
1. Postgres
2. Python
3. all
EOF
sudo read software
echo Software to install: $software

cat << EOF
Ingress the Software # to install :
1. Package Manager
2. Source Code
EOF
sudo read installation_type

echo Type of installation: $installation_type


echo "sudo yum update -y"
echo "sudo yum install git -y"


# echo "software = $software"

# Loop to install all the software

# sudo yum update -y
# sudo yum install git -y


if [ $installation_type = 1 ] 
then
# echo "installation folder : $"
folderInst=./centos8/pckmanager
else
folderInst=./centos8/source
fi

sudo git clone https://github.com/johannesanchez/linux-common-scripts.git

if [ $software = 1 ] 
then
# echo $software postgres
sw2inst="postgres12"
elif [ $software = 2 ]
then
# echo $software python
sw2inst="postgres12"
else
echo $software nothing
fi

cd $folderInst
echo sudo sh ./$sw2inst"-install.sh"