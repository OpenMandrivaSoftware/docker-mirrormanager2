# docker-mirrormanager2

Creates a mirrormanager2 image running with python. The image uses a python virtual environment and pip as the installer for the package and it's dependencies. The flask package is server by uwsgi and is designed to be proxied by an nginx server.
The mirrormanager package has been patched to run under python3 this also requires changes to the package requirements.
The following is a typical server block that may be used with nginx. Currently the uwsgi server outputs on port 3031. 
Status information is JSON format may be obtained via port 9191 via the browser.

server {
  listen 80 default_server;
  listen [::]:80 default_server;
  server_name <Domain name>;
  access_log /var/www/vhosts/<domain name>/logs/access_log;
  error_log  /var/www/vhosts/domain name/logs/error.log;
  location / {
    include uwsgi_params;
    uwsgi_pass mirrorman:3031;
  }
  
  BEWARE:
Some of the scripts provided with this server are very memory hungry this is particularly true of the crawler whose default setting would use 32Gb of memory.
