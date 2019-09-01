FROM legsplits/foolstack:base
COPY nginx.conf /etc/nginx/nginx.conf
CMD ["nginx"]
RUN apk --update --no-cache add nginx && rm /etc/nginx/conf.d/default.conf
