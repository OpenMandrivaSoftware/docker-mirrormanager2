#!/bin/sh

# Make needed directories
# MirrorManager configuration file
mkdir -p /etc/mirrormanager
# MirrorManager crawler log rotation
mkdir -p /etc/logrotate.d
# for .wsgi files mainly
mkdir -p /usr/share/mirrormanager2
# Stores temp files (.sock & co)
mkdir -p /var/lib/mirrormanager
# Results and homedir
mkdir -p /var/lib/mirrormanager
# Lock files
mkdir -p /var/lock/mirrormanager
# Stores lock and pid info
mkdir -p /var/run/mirrormanager
# Log files
mkdir -p /var/log/mirrormanager/crawler
# mirrorlist_server  dirs
mkdir -p  /var/lib/mirrormanager/pyvirt/mirrormanager/usr/share/mirrormanager/
# tmp files
#mkdir -p  /usr/lib/tmpfiles.d/
# Install crawler logrotate definition
# Create the supervisord log directory
mkdir -p /var/log/supervisor/
# Location for ini files
mkdir -p /etc/supervisord.d/
# Map data
mkdir -p /var/www/mirrormanager-statistics/data/propagation
# Statistics
mkfir -p /var/www/mirrormanager-statistics/data

install -m 644 utility/mm2_crawler.logrotate \
    /etc/logrotate.d/mm2_crawler

# Install umdl logrotate definition
install -m 644 utility/mm2_umdl.logrotate \
    /etc/logrotate.d/mm2_umdl

# Install WSGI file
install -m 644 utility/mirrormanager2.wsgi \
    /usr/share/mirrormanager2/mirrormanager2.wsgi
install -m 644 mirrorlist/mirrorlist_client.wsgi \
    /usr/share/mirrormanager2/mirrorlist_client.wsgi

# Install the mirrorlist server
install -m 644 mirrorlist/mirrorlist_server.py \
    /var/lib/mirrormanager/pyvirt/mirrormanager/usr/share/mirrormanager/mirrorlist_server.py
install -m 644 mirrorlist/weighted_shuffle.py \
     /var/lib/mirrormanager/pyvirt/mirrormanager/usr/share/mirrormanager/weighted_shuffle.py

# Install the tmpfile creating the /run/mirrormanager folder upon reboot
#install -m 0644 mirrorlist/systemd/mirrormanager_tempfile.conf \
#    /usr/lib/tmpfiles.d/mirrorlist2-mirrorlist.conf

install -m 0644 utility/backend_tempfile.conf \
    /usr/lib/tmpfiles.d/mirrormanager2-backend.conf

## Install the systemd service file
#install -m 644 mirrorlist/systemd/mirrorlist-server.service \
#    /lib/systemd/system/mirrorlist-server.service

#install -m 644 /emperor.uwsgi.service \
#    /lib/systemd/system/emperor.uwsgi.service

install -m 644 /mirrormanager2.cfg \
    /etc/mirrormanager/mirrormanager.cfg

install -m 644 /mirrormanager.ini \
    /etc/uwsgi/vassals/mirrormanager.ini

install -m 644 /mirrorlist_client.ini \
    /etc/uwsgi/vassals/mirrorlist_client.ini

# Install the zebra-dump-parser perl module
cp -r utility/zebra-dump-parser /usr/lib/mirrormanager2/

# Install the client files
mkdir -p /etc/mirrormanager-client
install -m 0644 client/report_mirror.conf \
    /etc/mirrormanager-client/report_mirror.conf

# Install the country_continent file from MaxMind
install -m 0644 /utility/country_continent.csv \
    /usr/share/mirrormanager2/country_continent.csv

# Install supervisord ini files
install -m 0644 /mirrorlist_clientOMA.ini \
    /etc/supervisord.d/mirrorlist_clientOMA.ini
install -m 0644 /mirrormanagerOMA.ini \
    /etc/supervisord.d/mirrormanagerOMA.ini

#cp /mirrorlist/systemd/mirrorlist-server.service /lib/systemd/system/
#cp /mirrorlist/systemd/mirrormanager_tempfile.conf  /usr/lib/tmpfiles.d/
#cp  /supervisord.conf /etc/supervisord/conf.d/

#Install the contab file
cp /mirrormanager.cron /var/spool/cron/
# Add users

# Install the alembic file.
install -m 644 /alembic.ini \
    /etc/mirrormanager/alembic.ini

# Create the db
MM2_CONFIG=/etc/mirrormanager/mirrormanager.cfg python /var/lib/mirrormanager/createdb.py

# Put the supervisord conf file in the right place
mv  /supervisord.conf /etc/supervisord.conf

# Clean up
/bin/rm -r /client /mirrorlist

cd /var/lib/mirrormanager
/bin/rm Flask_XML_RPC_Re-0.1.4-py3-none-any.whl createdb.py  mirrormanager2-0.9.0-py3-none-any.whl  requirements.txt  requirements_mirrorlist.txt  runserver.py  runtests.sh
