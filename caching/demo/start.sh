docker run --add-host="localhost:192.168.65.1" -p 80:80 -p 443:443 -v ~/dev/docker-nginx-ssl-secure/etc/nginx:/etc/nginx/external -v `pwd`:/usr/share/nginx/html/ elgreg/nginx-ssl:latest
