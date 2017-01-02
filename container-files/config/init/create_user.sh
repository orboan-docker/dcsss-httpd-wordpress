#!/bin/bash
#www user is always created. It's the user used by httpd!
user=www
pwd=$PASSWORD
# Comments supose $user is www
# Creating the www user only if it does not exist
ret=false
getent passwd $user >/dev/null 2>&1 && ret=true

if $ret; then
echo "user already exists";
else

useradd $user -d /var/$user
# Setting password for the www user
echo "${user}:${pwd}" | chpasswd
# Add 'www' user to sudoers
echo "${user}  ALL=(ALL)  NOPASSWD: ALL" > /etc/sudoers.d/$user
echo "user created"
fi
mkdir -p /var/$user/html
cp /etc/skel/.b* /var/$user
chown -R $user:$user /var/$user

#Creating another user if $USER is not www
user=$USER
ret=false
getent passwd $user >/dev/null 2>&1 && ret=true

if $ret; then
echo "user already exists";
else

useradd $user -d /home/$user
# Setting password for the !www user
echo "${user}:${pwd}" | chpasswd
# Add !'www' user to sudoers
echo "${user}  ALL=(ALL)  NOPASSWD: ALL" > /etc/sudoers.d/$user
echo "user created"
fi
mkdir -p /home/$user
cp /etc/skel/.b* /home/$user
chown -R $user:$user /home/$user
