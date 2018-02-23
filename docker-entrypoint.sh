#!/bin/bash
set -e

if [[ "$1" != "prosody" ]]; then
    exec prosodyctl $*
    exit 0;
fi

if [ "$LOCAL" -a  "$PASSWORD" -a "$DOMAIN" ] ; then
    echo "Creating user ${LOCAL}@${DOMAIN}"
    prosodyctl register $LOCAL $DOMAIN $PASSWORD
fi

exec "$@"
