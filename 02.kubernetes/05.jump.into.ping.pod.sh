#!/bin/bash

if [[ -z "$TRAINEE" ]]; then
    echo "Must provide TRAINEE in environment" 1>&2
    exit 1
fi


echo "you can now: ping training-service.$TRAINEE.svc.cluster.local or ping training-service"
echo "you can also run: curl http://training-service.$TRAINEE.svc.cluster.local"
echo "you can also try to reach the service from other trainees"

kubectl exec -ti pingpod -n $TRAINEE bash
