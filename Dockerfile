FROM node:18.17.0-buster-slim AS ui
RUN npm install -g npm@9
COPY ./ui/ /ui/
WORKDIR /ui
RUN npm install
RUN npm run build

FROM golang:1.22.3-alpine3.19 AS builder
WORKDIR /app
COPY main.go go.mod /app/
COPY --from=ui /ui/dist/ /app/dist/
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app
EXPOSE 8080

FROM alpine:latest
COPY --from=builder /app/app .
CMD ["./app"]
