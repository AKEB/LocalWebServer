FROM nginx:latest

# Install programs
RUN apt-get update
RUN apt-get install -y nano git procps ca-certificates

RUN mkdir -p /var/www/html

COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY root_ca.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates -v
