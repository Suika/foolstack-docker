# Foolfstack - torako + seaweedfs + ayase
Quick guide to using this stuff.
Non-local access is outside the current scope.

## Install preprequisites
* Install docker

https://docs.docker.com/engine/install/fedora/
```
## Update system packages
$ sudo dnf -y update
$ sudo dnf -y install dnf-plugins-core

## Add docker repository:
$ sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
$ sudo dnf makecache

## Install docker packages:
$ sudo dnf install docker-ce docker-ce-cli containerd.io 

## Start docker service:
$ sudo systemctl enable --now docker
$ systemctl status docker

## Add current user to docker group:
$ sudo usermod -aG docker $(whoami)

## "login" to docker group in an existing terminal session:
$ newgrp docker
```

* Install docker-compose
```
$ sudo dnf install docker-compose
```


## Prep
Seaweedfs does not implicaitly create many of its dirs.
This script makes them if they do not exist and assigns permissions permissive enough to make sure seaweedfs can use them.
```
$ bash mkdirs.sh
```


## Running:
Start/create containers in the background:
```
$ docker-compose -f "docker-compose.yml" up -d
```

Stop/remove containers:
```
$ docker-compose -f "docker-compose.yml" down
```


### Viewing logs
```
$ docker-compose -f "docker-compose.yml" logs
$ docker-compose -f "docker-compose.yml" logs ayase
```

### Running commands inside containers manually:
```
$ docker exec -it 4chan-scrape-db sh
container$ mysql -uroot -pbunbuncha
container.mysql> SELECT host, user FROM mysql.user;
```

Installing packages in container for diagnostics:
```
apt-get update && apt-get install -y traceroute curl iputils
```


## Ayase website
In a web browser, open this address to view the ayase instance provided by the container "ayase":

`http://127:0.0.1:29080/`


## DB Export
* Note: The method demonstrated does not strip secrets such as deletion passwords or IP addresses from the generated file.

Backup the entire database:
```
$ docker exec "4chan-scrape-db" /usr/bin/mysqldump -h"localhost" -u"root" -p"bunbuncha" --tz-utc --quick --opt --single-transaction  --skip-lock-tables --all-databases  | gzip > "4chan-scrape-db.all-databases.t`date -u +%s`.sql.gz"
```

Export a single board:
```
$ docker exec "4chan-scrape-db" /usr/bin/mysqldump -h"localhost" -u"root" -p"bunbuncha" --tz-utc --quick --opt --single-transaction  --skip-lock-tables "asagi" "g" "g_images" | gzip > "4chan-scrape-db.g.t`date -u +%s`.sql.gz"
```

Export multiple boards:
```
$ docker exec "4chan-scrape-db" /usr/bin/mysqldump -h"localhost" -u"root" -p"bunbuncha" --tz-utc --quick --opt --single-transaction  --skip-lock-tables "asagi" "g" "g_images"  "co" "co_images" | gzip > "4chan-scrape-db.my_boards_export.t`date -u +%s`.sql.gz"
```
