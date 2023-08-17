# Create Certificates

## Create Root Certificate

[Documentation](https://habr.com/ru/articles/671730/)

* Для нашего CA генерируем приватный ключ 2048-бит RSA. Администратор CA должен хранить его в секрете от всех:

```bash
openssl genrsa -out root_ca.key 2048
```

* Далее для нашего CA генерируем X.509 сертификат на 365 дней (root_ca.crt) и подписываем его приватным ключом (root_ca.key). Получается самоподписанный сертификат, его можно и нужно будет скопировать на все компьютеры, между которыми необходимо организовать TLS соединение. При ответах на вопросы, которые будет задавать OpenSSL, можно указывать произвольные данные, CA я назвал "My CN":

```bash
openssl req -x509 -new -key root_ca.key -days 36500 -out root_ca.crt

openssl x509 -in root_ca.crt -out root_ca.pem -outform PEM
```

* Смотрим получившийся сертификат, убеждаемся, что данные в нем корректные:

```bash
openssl x509 -text -in root_ca.crt
```

root_ca.crt необходимо добавить в связку ключей, и доверять ему

Нужно добавить в .bash_profile следующую строчку *Не забудьте поменять путь на свой до файла root_ca.crt*

```bash
export CURL_CA_BUNDLE=~/Work/LocalWebServer/ssl/root_ca.crt
```

## Создание сертификата для домена

Создаем файл ./ssl/domains.conf
Прописываем в ./ssl/domains.conf две строчки

```bash
domains[0]="localhost my.local.ru my.local.com"
certnames[0]="localhost"
```

Запускаем скрипт

```bash
./cert.sh
```

Если папки localhost не существовало, то она появится и внутри будут сертификаты
