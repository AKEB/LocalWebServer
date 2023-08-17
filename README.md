# Local Web Server For Developers

It is a simple Nginx proxy manager + php-fpm + mysql + phpmyadmin web server

## Run web server

```bash
docker-compose up -d
```

Then open [http://localhost:81/](http://localhost:81/)

```bash
Email:    admin@example.com
Password: changeme
```

### Add new proxy host

```bash
Domain Name:           my.example.ru my.example.com
Scheme:                http
Forward Hostname / IP: host.docker.internal
Forward Port:          8080
```

### SSL Certicate

Please read the file [README.md](./ssl/README.md) in the ssl folder.

If an SSL certificate is required, under *SSL Certificates* section select *Add SSL Certificate* and add a custom certificate.

```bash
Name:                     my-example-ru
Certificate Key:          ./ssl/example/example.key
Certificate:              ./ssl/example/example.crt
Intermediate Certificate: ./ssl/example/root_ca.pem
```

* Go to *Proxy Hosts* section and edit my.example.ru.
* Go to SSL section and select your custom certificate
* After save and run example project, you can check it [https://my.example.ru](https://my.example.ru)

## Example Project

### Prepare example project

```bash
cd ./example/docker/

echo "127.0.0.1    my.example.ru" >> /etc/hosts # Add domain IP address into /etc/hosts file
echo "127.0.0.1    my.example.com" >> /etc/hosts # Add domain IP address into /etc/hosts file

echo "NGINX_PORT=8080" > .env # Add port settings into .env file
```

### Run example project

```bash
cd ./example/docker/

docker-compose up -d
curl -k "http://my.example.ru:8080"
```

## SSL Certificates


## Reconfigure php-fpm or nginx

Make changes into each folder and then run *./build_docker_php_fpm.sh* file
