# Asagi on Docker

Built on top of `alpine:latest` with `openjdk11`.
Configuration is done via `environment` or `env` file.
`command:` can be changed, but has to contain `java -jar asagi.jar`, duh.
```
version: '2'
services:
  asagi:
    image: suika/foolstack:asagi
    container_name: asagi
    restart: always
    environment:
      - UID=1000
      - GID=1000
      - ASAGI_DB_HOST=some.other.host
    volumes:
      - ./boards:/boards  # storage where images and thumbs will be written to
```


## Environment variables
Default environment variables.

```
UID=1000  # User under which process will run and files be saved
GID=1000  # Group under which process will run and files be saved

# Read https://wiki.bibanon.org/FoolFuuka/Install/Ubuntu16#Configure_Asagi
ASAGI_ENGINE=Mysql
ASAGI_DB=asagi
ASAGI_DB_HOST=foolstack-db
ASAGI_DB_USERNAME=asagi
ASAGI_DB_PASSWORD=pass
ASAGI_DB_CHARSET=utf8mb4
ASAGI_DL_PATH=/boards/
ASAGI_OLD_DIR_STRUCT=false
ASAGI_WEBSERVER_GROUP=www
ASAGI_THUMB_THREAD_NUM=3
ASAGI_MEDIA_THREAD_NUM=0
ASAGI_NEW_THREADS_THREADS=3
ASAGI_DEL_THREAD_THRESH_PAGE=8
ASAGI_REFRESH_DELAY=30
ASAGI_THROT_API=true
ASAGI_THROT_URL=a.4cdn.org
ASAGI_THROT_MILLSEC=11100
ASAGI_REFRESH_RATE=10
ASAGI_THREADS='"3": {},"a": {},"aco": {},"adv": {},"an": {},"asp": {},"b": {},"biz": {},"c": {},"cgl": {},"ck": {},"cm": {},"co": {},"d": {},"diy": {},"e": {},"f": {},"fa": {},"fit": {},"g": {},"gd": {},"gif": {},"h": {},"hc": {},"hm": {},"his": {},"hr": {},"i": {},"ic": {},"int": {},"jp": {},"k": {},"lgbt": {},"lit": {},"m": {},"mlp": {},"mu": {},"n": {},"news": {},"o": {},"out": {},"p": {},"po": {},"pol": {},"qa": {},"qst": {},"r": {},"r9k": {},"s": {},"s4s": {},"sci": {},"soc": {},"sp": {},"t": {},"tg": {},"toy": {},"trash": {},"trv": {},"tv": {},"u": {},"v": {},"vg": {},"vp": {},"vr": {},"w": {},"wg": {},"wsg": {},"wsr": {},"x": {},"y": {}'
```
