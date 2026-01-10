FROM oryd/oathkeeper:v25.4.0 AS oathkeeper

FROM alpine:3.20

RUN apk add --no-cache ca-certificates gettext

COPY --from=oathkeeper /usr/bin/oathkeeper /usr/bin/oathkeeper

COPY oathkeeper.yml.tmpl /etc/oathkeeper/oathkeeper.yml.tmpl
COPY rules /etc/oathkeeper/rules
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 4455 4456
ENTRYPOINT ["/entrypoint.sh"]
