# Hay[D]en in docker
[Hayden](https://github.com/bbepis/Hayden) is an altearnative to asagi with the focus of minimal resources swasted.

Need to fix the permissions, it runs as `root` as of now. But other than that, just mount to the config into `/hayden/Hayden/config.json` and let it run.

```
UID=1000
GID=1000

SCRAPER_DB_HOST=foolstack-db
SCRAPER_DB_PORT=3306
SCRAPER_DB_NAME=asagi
SCRAPER_DB_USER=asagi
SCRAPER_DB_PASS=pass
SCRAPER_DB_CHARSET=utf8mb4
SCRAPER_DB_IGNORE_PREPARE=false
SCRAPER_DB_TYPE=Asagi

SCRAPER_TYPE=4chan
SCRAPER_BORADS_DELAY=30
SCRAPER_API_DELAY=0.8

SCRAPER_PROXY_TYPE=socks
SCRAPER_PROXY_URL=http://localhost:3182
SCRAPER_PROXY_USER=UGAYNAO
SCRAPER_PROXY_PASS=2big4u

SCRAPER_IMGDIR=/boards
SCRAPER_DOWNLOAD_MEDIA=true
SCRAPER_DOWNLOAD_THUMBS=true
SCRAPER_DB_POOLSIZE=12

SCRAPER_BOARDS=bant,c,e,n,news,out,p,toy,vip,vp,w,wg,wsr
```

```
version: '2'
services:
  hayden:
    image: legsplits/hayden:alpine
    container_name: hayden
    restart: unless-stopped
    volumes:
      - HAYDEN_CONFIG:/hayden/Hayden/config.json:ro
    tmpfs:
      - /tmp #optional for SPEEEEEEEEEEEEEEEEEEEEEEEEED and less disk access
```