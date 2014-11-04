#!/bin/sh
if [ $# -ge 2 ]; then
  DOMAIN=$1
  BACKUPDEST=$2
else
  echo "Usage: sh ./scripts/backups-init.sh domain gitrepo"
  exit 1
fi
echo "Adding backup job for $DOMAIN to $BACKUPDEST"

echo "First, trying to clone latest master from $BACKUPDEST"
git clone $BACKUPDEST /data/domains/$DOMAIN/backup

sudo mkdir -p /data/domains/$DOMAIN/backup
sudo echo "$BACKUPDEST" > /data/domains/$DOMAIN/backup/BACKUPDEST

echo initializing backups for $DOMAIN
mkdir -p /data/domains/$DOMAIN/backup/mysql
mkdir -p /data/domains/$DOMAIN/backup/www
mkdir -p /data/domains/$DOMAIN/backup/TLS
cd /data/domains/$DOMAIN/backup/
git config --local user.email "backups@`hostname`"
git config --local user.name "`hostname` hourly backups"
git config --local push.default simple

if [ -e /data/domains/$DOMAIN/backup/.git ]; then
  git init
fi
echo "backups of $DOMAIN at IndieHosters server `hostname`" > README.md
git add README.md
git commit -m"initial commit"

echo "Pushing initial commit to $BACKUPDEST master branch"
cd /data/domains/$DOMAIN/backup/
git remote add destination $BACKUPDEST
git push -u destination master