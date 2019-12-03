FROM suika/foolstack:base
COPY nginx.conf /etc/nginx/nginx.conf
CMD ["nginx"]
RUN apk --update --no-cache add nginx && rm /etc/nginx/conf.d/default.conf
HEALTHCHECK --interval=10s --timeout=5s --retries=3 \
  CMD wget --quiet --tries=1 --no-check-certificate --spider \
  http://localhost:80 || exit 1
