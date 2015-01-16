== README

This is Planets BaseBall Team Web Site Demo

Things you may want to cover:

* Ruby version 2.1.2

* Rails version 4.1.6

* Database Mysql2

* Capistrano 3

* Nginx + Unicorn

* Bootstrap-sass 3 + fontawesome

* Omniauth-facebook

* Sakura VPS

Planet Password
```
password
```

Site URL ： http://planets-nine.com

Basic認証　： 2015年1月現在は直接伝えます。(今後オープン予定)

ローカルへのセットアップ
```
$ git clone git@github.com:r-wataru/planets.git
$ vi config/database.yml
development:
  adapter: mysql2
  encoding: utf8
  reconnect: false
  database: planets_development
  pool: 5
  username: root
  password:
  host: localhost

test:
  adapter: mysql2
  encoding: utf8
  reconnect: false
  database: planets_test
  pool: 5
  username: root
  password:
  host: localhost

$ rake db:setup

※ ローカルの場合、3000ポートのみfacebookログインが使えます。
```