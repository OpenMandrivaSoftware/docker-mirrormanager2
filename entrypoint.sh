#!/bin/bash

/usr/bin/supervisord -c /etc/supervisord.conf
#uwsgi --socket :3031 --wsgi-file /home/mman/mirrormanager2.wsgi --uid mman --processes 2 --threads 2 --stats :9191 --stats-http
