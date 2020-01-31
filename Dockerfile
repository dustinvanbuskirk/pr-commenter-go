# Build PR Commenter

FROM golang:1.11.2 as builder
RUN go get -u github.com/dustinvanbuskirk/github-commenter 
WORKDIR /go/src/github.com/dustinvanbuskirk/github-commenter
RUN CGO_ENABLED=0 go build -v -o "./dist/bin/github-commenter" *.go

# Tooling Image
FROM alpine:3.8
RUN apk add --no-cache ca-certificates
COPY --from=builder /go/src/github.com/dustinvanbuskirk/github-commenter/dist/bin/github-commenter /usr/bin/github-commenter
ENV PATH $PATH:/usr/bin
ENTRYPOINT ["github-commenter"]