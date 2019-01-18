#!/bin/bash

cp /mirrorlist/systemd/mirrorlist-server.service /lib/systemd/system/
cp /mirrorlist/systemd/mirrormanager_tempfile.conf

uwsgi --socket :3031 --wsgi-file /home/mman/mirrormanager2.wsgi --uid mman --processes 2 --threads 2 --stats :9191 --stats-http