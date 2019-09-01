FROM alpine:latest
WORKDIR /asagi
RUN apk add git maven openjdk11
RUN git clone https://github.com/desuarchive/asagi.git /asagi
RUN mvn package assembly:single

FROM alpine:latest
CMD ["java", "-XX:+UseParallelGC", "-XX:+UseParallelOldGC", "-verbose:gc", "-jar", "asagi.jar"]
RUN apk --update --no-cache add openjdk11-jre
WORKDIR /asagi
RUN adduser -D -g 'www' www && chown www:www -R /asagi

USER www

COPY --from=0 --chown=www /asagi/target/asagi-0.4.0-SNAPSHOT-full.jar /asagi/asagi.jar
