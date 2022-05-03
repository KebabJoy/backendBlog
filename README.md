### README

## Первоначальная установка, возможные решения проблем
* установка mysql 8.0 на Ubuntu 20 тоже работает: `https://blog.sedicomm.com/2018/05/25/kak-ustanovit-mysql-8-0-v-ubuntu-18-04/`
  * скопируйте файл конфигураций БД: `cp config/database.yml.example config/database.yml`
* Для использования WeatherAPI вам понадобится apikey. Получить его нужно тут `https://developer.accuweather.com/`. И установите значение в файл .env
```
cp .env .env.example
```
---

