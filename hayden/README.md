# Hay[D]enn in docker
[Hayden](https://github.com/bbepis/Hayden) is an altearnative to asagi with the focus of minimal resources swasted.

Need to fix the permissions, it runs as `root` as of now. But other than that, just mount to the config into `/hayden/Hayden/config.json` and let it run.

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
