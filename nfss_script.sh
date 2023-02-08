#!/bin/bash
yum install -y nfs-utils
systemctl enable firewalld.service --now
firewall-cmd --add-service="nfs3" --add-service="rpc-bind" --add-service="mountd" --permanent
firewall-cmd --reload
systemctl enable nfs --now
mkdir -p /srv/share/upload
chown -R nfsnobody:nfsnobody /srv/share
chmod 0777 /srv/share/upload
touch /etc/exports
echo "/srv/share 192.168.56.201/32(rw,sync,root_squash)" > /etc/exports
exportfs -r
