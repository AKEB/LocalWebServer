FROM nginx:latest

RUN mkdir -p /app \
	&& mkdir -p /etc/cron.weekly \
	&& mkdir -p /usr/share/GeoIP

COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY root_ca.crt /usr/local/share/ca-certificates/
COPY geoip_update.sh /etc/cron.weekly/geoip_update
COPY geoip_update.sh /root/geoip_update.sh

# Install programs
RUN apt-get clean && apt-get dist-upgrade \
	&& apt-get update -y --allow-insecure-repositories \
	&& apt-get install -y --allow-unauthenticated \
	nano git procps ca-certificates mc wget curl iputils-ping

RUN mkdir -p /var/log/nginx/ && touch /var/log/nginx/error.log && touch /var/log/nginx/access.log

RUN chmod +x /root/geoip_update.sh \
	&& chmod +x /etc/cron.weekly/geoip_update \
	&& /root/geoip_update.sh \
	&& update-ca-certificates -v
