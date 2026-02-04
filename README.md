# Генерация самоподписного сертификата
Используется для локальной разработки вэб-приложений

Работает только на Unix-системах. На Windows рекомендую использовать приложение Ubuntu на WSL2 из магазина приложений.
1. Клонируем проект и переходим в папку
    ```shell
    git clone git@github.com:e-terin/self-signed-certificate.git && cd self-signed-certificate
    ```
2. Запускаем в терминале
    ```shell
    make generate-cert DOMAIN=mysite.local
    ```
заполняем страну, город, компанию, все остальное можно пропустить.

Сертификаты берем из появившейся папки `ssl`

Пример настройки `nginx`:
```shell
ssl_certificate           /ssl/site.crt;
ssl_certificate_key       /ssl/site.key;
```

В браузере нужно добавить корневой серт `rootCA.crt` в доверенные 
```shell
chrome://certificate-manager/localcerts/usercerts
```