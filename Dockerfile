FROM golang:1.26-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /my-app ./
ENTRYPOINT ["/my-app"]


FROM alpine:latest AS application
WORKDIR /app
COPY --from=builder /my-app ./my-app
ENTRYPOINT ["./my-app"]
