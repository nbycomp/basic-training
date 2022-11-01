- Apply a resource:
`kubect apply -f resource.yaml`

- List a resource type (example):
`kubectl get pods -n $TRAINEE`

- List a resource type (example):
`kubectl get pods -n $TRAINEE -o yaml`

- Delete a resource:
`kubectl delete -f resource.yaml`


In this training:

`sh apply.sh resource.yaml`

and

`sh delete.sh resource.yaml`


Notice that in step 06 (Nodeport) you'll have to change your port number to avoid collisions
