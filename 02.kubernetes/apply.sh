#!/bin/bash

if [[ -z "$TRAINEE" ]]; then
    echo "Must provide TRAINEE in environment" 1>&2
    exit 1
fi

sed -e 's/<traineeid>/'$TRAINEE'/g' $1 | kubectl apply -f -
