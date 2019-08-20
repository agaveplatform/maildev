#!/usr/bin/env ash

# If a command is passed, run it.
#if [ -n "$@" ]; then
#    echo "Running passed in commmand."
#    exec "$@"
#
## Otherwise build a command from the environment
#else
    echo "Building command from environment"

    CMD="bin/maildev --web=80 --ip=0.0.0.0"

    if [ -n "$BASE_PATHNAME" ]; then
        CMD="$CMD --base-pathname $BASE_PATHNAME"
    fi

    if [ -n "$INCOMING_USERNAME" ]; then
        CMD="$CMD --incoming-user='$INCOMING_USERNAME'"
    fi

    if [ -n "$INCOMING_PASSWORD" ]; then
        CMD="$CMD --incoming-pass='$INCOMING_PASSWORD'"
    fi


    if [ -n "$OUTGOING_HOST" ] && [ -n "$OUTGOING_USER" ] && [ -n "$OUTGOING_PASS" ]; then

        if [ -n "$OUTGOING_SECURE" ]; then
            echo "Secure forwarding is configured for $OUTGOING_HOST."
            CMD="$CMD --outgoing-secure"
        else
            echo "Insecure forwarding is configured for $OUTGOING_HOST."
        fi

        CMD="$CMD --outgoing-host=$OUTGOING_HOST --outgoing-user=$OUTGOING_USER --outgoing-pass=$OUTGOING_PASS"

    else

        echo "Outgoing host and credentials were not supplied. Forwarding will be disabled."

    fi

    if [ -z "$DISABLE_WEB" ]; then

        if [ -n "$WEB_USER" ] && [ -n "$WEB_PASS" ]; then
            echo "Webapp authentication is enabled"

            CMD="$CMD --web-user=$WEB_USER --web-pass=$WEB_PASS"
        else
            echo "Webapp authentication is disabled"
        fi

    else

        echo "Web interface is disabled"

    fi


    if [ -n "$AUTO_RELAY_RULES" ]; then
        CMD="$CMD --auto-relay --auto-relay-rules=$AUTO_RELAY_RULES"
    fi

    # Run the assembled command
    echo "${CMD}"
    exec $CMD

#fi