FROM alpine:3.19

# Installer PostgreSQL client et bash
RUN apk add --no-cache postgresql-client bash

WORKDIR /backup

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
