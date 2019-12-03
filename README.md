# FoolStack

A full FoolFuuka stack on top of docker to remove the setup overhead and allow portability.

1. Save [docker-compose.yml](docker-compose.yml) (and maybe .env) on your system. Edit `foolstack-scraper` environment
2. Adjust `foolstack-scraper` and add the boards you wish to archive
3. `docker-compose up -d` >>  http://yourhost:8080/admin Login:`admin:admin`
4. Add the boards, that you defined in `foolstack-scraper`, in the webui.
5. Run "Trigger search indexing" (see bellow). You will get ERRORS, just run it again till none are displayed.
6. Restart the `foolstack-sphinx` container

Trigger search indexing: `docker container run -ti --rm --volumes-from foolstack-sphinx --net=container:foolstack-sphinx --name foolstack-sphinx-index suika/foolstack:manticore indexer --rotate --all`

Trigger background search indexing: `docker container run -t -d --rm --volumes-from foolstack-sphinx --net=container:foolstack-sphinx --name foolstack-sphinx-index suika/foolstack:manticore indexer --rotate --all`

Dunno why `docker exec -it foolstack-sphinx indexer --rotate --all` is killed. If you do, drop an issue.

### Permission
If you are binding directories:
 * ff-db `999:999`
 * ff-sphinx-data: `101:101`
 * The rest is `1000:1000`
----------------------
```yaml
version: "2.1"
services:
  foolstack-db:
    image: suika/foolstack:percona
    container_name: foolstack-db
    restart: always
    networks:
      - foolstack
    environment:
      MYSQL_ROOT_PASSWORD: pass
    volumes:
      - ff-db:/var/lib/mysql
      - ff-db-logs:/var/log/mysql
  foolstack-php:
    image: suika/foolstack:php
    container_name: foolstack-php
    restart: always
    networks:
      - foolstack
    depends_on:
      foolstack-db:
          condition: service_healthy
      foolstack-redis:
          condition: service_healthy
    volumes:
      - ff-foolframe-temp:/var/www/foolfuuka/public/foolframe/foolz
      - ff-foolfuuka-temp:/var/www/foolfuuka/public/foolfuuka/foolz
      - ff-foolfuuka-conf:/var/www/foolfuuka/app/foolz/foolfuuka/config
      - ff-foolframe-conf:/var/www/foolfuuka/app/foolz/foolframe/config
      - ff-foolframe-logs:/var/www/foolfuuka/app/foolz/foolframe/logs
#      - ff-boards:/var/www/foolfuuka/public/foolfuuka/boards # uncomment for image uploads by foolfuuka
  foolstack-nginx:
    image: suika/foolstack:nginx
    container_name: foolstack-nginx
    restart: always
    networks:
      - foolstack
    depends_on:
      foolstack-db:
        condition: service_healthy
      foolstack-php:
        condition: service_healthy
      foolstack-redis:
        condition: service_healthy
    volumes:
      - ff-foolframe-temp:/var/www/foolfuuka/public/foolframe/foolz:ro
      - ff-foolfuuka-temp:/var/www/foolfuuka/public/foolfuuka/foolz:ro
      - ff-boards:/var/www/foolfuuka/public/foolfuuka/boards:ro
    ports:
      - 8080:80
  foolstack-redis:
    container_name: foolstack-redis
    image: healthcheck/redis
    restart: always
    networks:
      - foolstack
    volumes:
      - ff-redis:/data
  foolstack-scraper:
    image: suika/foolstack:hayden # :asagi :eve :hayden
    container_name: foolstack-scraper
    restart: always
    networks:
      - foolstack
    depends_on:
      foolstack-db:
        condition: service_healthy
    environment:
      - SCRAPER_BOARDS=w,wg
      - SCRAPER_DOWNLOAD_MEDIA=True
      - SCRAPER_DOWNLOAD_THUMBS=True
    volumes:
      - ff-boards:/boards
  foolstack-sphinx:
    image: suika/foolstack:manticore
    container_name: foolstack-sphinx
    restart: always
    networks:
      - foolstack
    depends_on:
      foolstack-db:
        condition: service_healthy
    volumes:
      - ff-sphinx-data:/var/lib/manticore
      - ff-sphinx-logs:/var/log/manticore
volumes:
  ff-foolframe-temp:     # FoolFrame generated content on the fly via php
    driver: local
  ff-foolfuuka-temp:     # FoolFuuka generated content on the fly via php
    driver: local
  ff-foolframe-logs:     # FoolFrame logs
    driver: local
  ff-foolfuuka-conf:     # Persistent configs
    driver: local
  ff-foolframe-conf:     # Persistent configs
    driver: local
  ff-db:                 # Percona DB
    driver: local
  ff-db-logs:            # Percona DB Logs
    driver: local
  ff-sphinx-data:        # MantiCore DB
    driver: local
  ff-sphinx-logs:        # MantiCore Logs
    driver: local
  ff-boards:             # Downloaded images and thumbs
    driver: local
  ff-redis:              # Redis
    driver: local
networks:
  foolstack:
    name: foolstack
```