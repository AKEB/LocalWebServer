# Create Certificates

## Create Root Certificate

[Documentation](https://habr.com/ru/articles/671730/)

* For our CA we generate a 2048-bit RSA private key. The CA administrator must keep it secret from everyone:

```bash
openssl genrsa -out root_ca.key 2048
```

* Next, for our CA we generate X.509 certificate for 36500 days (root_ca.crt) and sign it with a private key (root_ca.key). We get a self-signed certificate, which can and should be copied to all computers between which we need to organise a TLS connection. When answering the questions that OpenSSL will ask, you can specify arbitrary data, CA I called "My CN":

```bash
openssl req -x509 -new -key root_ca.key -days 36500 -out root_ca.crt

openssl x509 -in root_ca.crt -out root_ca.pem -outform PEM
```

* View the resulting certificate and make sure that the data in it is correct:

```bash
openssl x509 -text -in root_ca.crt
```

root_ca.crt should be added to the keychain, and trusted with it

Add the following line to the .bash_profile *Don't forget to change the path to your absolute path to the root_ca.crt file*

```bash
export CURL_CA_BUNDLE=~/Work/LocalWebServer/ssl/root_ca.crt
```

## Создание сертификата для домена

Create the ./ssl/domains.conf file
Write this two lines in ./ssl/domains.conf

```bash
domains[0]="my.example.ru my.example.com"
certnames[0]="example"
```

Run the script

```bash
./cert.sh
```

If the ./ssl/example folder did not exist, it will appear and there will be certificates inside it
