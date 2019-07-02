
Issue
-----

```
➜ go version
go version go1.12.6 linux/amd64

➜ make issue 
rm -rf go.mod
go mod init github.com/ekalinin/go-readonly
go: creating new go.mod: module github.com/ekalinin/go-readonly

➜ make image 
sudo docker build . -t go-readonly
Sending build context to Docker daemon  88.06kB
Step 1/8 : FROM golang:1.12-alpine AS build
 ---> 4e4b7a8b9495
Step 2/8 : RUN apk add --no-cache curl git ca-certificates   && addgroup -S build && adduser -S -G build build
 ---> Using cache
 ---> a4d7e4ce418c
Step 3/8 : WORKDIR /srv
 ---> Using cache
 ---> 08d9489328f1
Step 4/8 : COPY . ./
 ---> 4d82cf2a6927
Step 5/8 : USER build
 ---> Running in 21454da70f0c
Removing intermediate container 21454da70f0c
 ---> 24d9e132495e
Step 6/8 : RUN go mod download
 ---> Running in 487b0d968a18
go: open /srv/go.mod: permission denied
The command '/bin/sh -c go mod download' returned a non-zero code: 1
Makefile:2: recipe for target 'image' failed
make: *** [image] Error 1
```

Fix
---

```
➜ make fix                                                                       
chmod a+r go.mod 

➜ make image 
sudo docker build . -t go-readonly
Sending build context to Docker daemon  89.09kB
Step 1/8 : FROM golang:1.12-alpine AS build
 ---> 4e4b7a8b9495
Step 2/8 : RUN apk add --no-cache curl git ca-certificates   && addgroup -S build && adduser -S -G build build
 ---> Using cache
 ---> a4d7e4ce418c
Step 3/8 : WORKDIR /srv
 ---> Using cache
 ---> 08d9489328f1
Step 4/8 : COPY . ./
 ---> 6dd3c7d71483
Step 5/8 : USER build
 ---> Running in f28a724af7b3
Removing intermediate container f28a724af7b3
 ---> e4ce3d8e9d96
Step 6/8 : RUN go mod download
 ---> Running in 1a33b9966fdb
Removing intermediate container 1a33b9966fdb
 ---> f82026f31b84
Step 7/8 : RUN go mod verify
 ---> Running in a012ec3edd4d
all modules verified
Removing intermediate container a012ec3edd4d
 ---> 5cf6d8501ac9
Step 8/8 : RUN CGO_ENABLED=0 go build -mod=readonly -o ~/server ./cmd/server.go
 ---> Running in af2d2107191f
Removing intermediate container af2d2107191f
 ---> 8ce4ecae493a
Successfully built 8ce4ecae493a
Successfully tagged go-readonly:latest
```
