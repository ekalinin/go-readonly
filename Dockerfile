FROM golang:1.12-alpine AS build
RUN apk add --no-cache curl git ca-certificates \
  && addgroup -S build && adduser -S -G build build
WORKDIR /srv
COPY . ./
USER build
RUN go mod download
RUN go mod verify
RUN CGO_ENABLED=0 go build -mod=readonly -o ~/server ./cmd/server.go
