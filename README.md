# About

This is a simple example showing gRPC go-lang service available on GKE

# Setup

```
$ make

build                          Build docker image
deploy-endpoint                Deploy endpoint
gen                            Stub proto
push                           push image
run                            run image
sh                             sh into image

```

# Deploy

```
$ gcloud container clusters create echo-cluster --zone us-central1-a
$ kubetcl apply -f manifest/echo-grpc.yaml
```