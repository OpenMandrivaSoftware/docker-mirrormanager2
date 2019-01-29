# docker-mirrormanager2

Creates a mirrormanager2 image running with python. The image uses a python virtual environment and pip as the installer for the package and it's dependencies. The flask package is served by uwsgi and is 
designed to be proxied by an nginx server.
The mirrormanager package has been updated to run under python3 this also required changes to the package requirements.
Some wheel packages were generated locally to ensure the correct versions.
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
  
There is a second server 
  
  BEWARE:
Some of the scripts provided with this server are very memory hungry this is particularly true of the crawler whose default setting would use 32Gb of memory.

To make a start build the images with "docker build -f Dockerfile.p3 -t mirrmn2-py3-prst ." from within the repo directory
To run:-  docker run --name oma-mirrorman -d mirrmn2-py3-prst3
To run a shell inside the container and connect to it:- docker exec -it oma-mirrorman /bin/bash
To stop container: docker stop oma-mirrorman
To clean up container:- docker rm oma-mirrorman
To remove image:- docker rmi mirrmn2-py3-prst

Note that the mirrorlist_server will not start until the pkl file is generated.
Here are some very basic instructions for generating that file. 

The first requirement is to run the script mm2_update-master-directory-list on the master mirror
Then add one mirror and run the crawler against it

Repository detection may not work since it is hardcoded to fedora
