**Сборка контейнеров docker для локальной работы с 1С-Битрикс**

Данная сборка НЕ предназначена для использования на боевых серверах (только локально).

Сборка содержит в себе:

1. nginx
2. mariaDB
3. php-fpm
4. php-cli
5. supervisor (для запуска агентов)
6. phpmyadmin
7. mailhog (эмуляция отправки почты)

Протестировано:
1. Linux Ubuntu
2. Macbook 

Как использовать:

1. Клонировать репозиторий
```bash
git clone https://github.com/vbcherepanov/bitrixdocker.git 
```
2. Перейти в каталог bitrixdocker
```bash
cd bitrixdocker
```
3. Создать файл переменных окружения
```bash
cp .env.example .env 
```
4. Создаем новый сайт:
   1. в каталоге **www** создаем новый каталог для сайта, например **site**
   2. идем в каталог docker/images/nginx/conf.d и создаем файл site.conf
   3. копируем в него содержимое файла bitrix.conf и корректируем настройку
      1. server_name site.local; (тут указываем по какому домену надо отвечать)
      2. root /var/www/site; (тут указываем каталог где будет сайт)
   4. Создадим конфигурацию для supervisor:
      1. идем в каталог /docker/images/php/supervisor/conf.d
      2. создаем файл site.conf и копируем в него содержимое bitrix.conf
      3. корректируем под наш сайт site
         1. в первое строке пишем название нашего задания: [program:site]
         2. в строке 3 - вместо bitrix-dev пишем site - это путь до файла запуска заданий в битриксе 
         3. остальное можно оставить как есть.
   5. идем в файл docker-compose.yml
      1. ищем extra_hosts:
      2. после строки bitrix-dev.local:172.20.0.7 добавляем строку с нашим доменом site.local:172.20.0.7
   6. чтобы наш сайт открывался по домену нужно прописать в файл hosts на локальной машине 172.20.0.7 site.local 
5. Запустить сборку
```bash
make build
make up
```

**Переменные в файле .env:**

* COMPOSE_PROJECT_NAME=bitrixdocker (название проекта docker)
* DB_ROOT_PASSWORD=secret  (пароль для MARIADB для пользователя root)
* DB_NAME=bitrix (наименование базы данных)
* DB_USERNAME=user (пользователь БД)
* DB_PASSWORD=secret (пароль пользователя БД)
* APP_PORT=8091 (порт приложения на локальной машине - прокидывается на порт 80 внутри контейнера)
* PHPMYADMIN_PORT=8184 (порт для phpmyadmin будет доступно по localhost:8184 например) 
* DB_PORT=33061 (порт mariadb на локальной машине)
* MAILHOG_WEB_PORT=8025 (порт для веб приложения mailhog)
* MAILHOG_PORT=1025 (порт для отправки почты mailhog )
* MEMCACHED_PORT=11215 (порт memcached для локальной машины)
* DEFAULT_DOMAIN=bitrix-dev.local (домен по умолчанию)
* BITRIX_VM_VER=7.5.2 (версия виртуальной машины битрикс - чтобы не было ошибки при проверке сайта)
* PHP_VERSION=7 (версия php: если 7 то установит версию 7.4, если 8 то версию 8.1)

**Команды Make:**

* up (запустить все сервисы)
* down (остановить все сервисы и удалить тома данных)
* restart (перезагрузить все сервисы)
* build (собрать контейнеры)
* pull (загрузить свежие образы сервисов)

При запуске создается сеть docker с определенной подсетью 172.20.0.0/24

**Как сделать чтобы под MAC сеть автоматом подключалась и прокидывались роуты**

устанавливаем утилиту

```bash
brew install chipmk/tap/docker-mac-net-connect
sudo brew services start chipmk/tap/docker-mac-net-connect
```
