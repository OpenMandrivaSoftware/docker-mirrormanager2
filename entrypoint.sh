#!/bin/bash

# python /home/mman/pyvirt/mirrormanager/bin/creatdb.py
# python /home/mman/runserver.py
#uwsgi --http :9090 --wsgi-file /home/mman/mirrormanager2.wsgi
uwsgi --socket :3031 --wsgi-file /home/mman/mirrormanager2.wsgi --uid mman --processes 2 --threads 2 --stats :9191 --stats-http