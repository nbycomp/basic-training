#!/bin/bash


if [[ -z "$TRAINEE" ]]; then
    echo "Must provide TRAINEE in environment" 1>&2
    exit 1
fi

docker run  -ti $TRAINEE-sample
