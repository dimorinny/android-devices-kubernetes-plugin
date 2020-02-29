FROM golang:1.14-alpine as builder

RUN apk add --no-cache gcc musl-dev alpine-sdk libusb-dev

WORKDIR /plugin
COPY . .

RUN go build -mod vendor


FROM alpine

RUN apk add --no-cache libusb-dev

COPY --from=builder /plugin/android-farm-kubernetes-plugin /usr/bin/android-farm-kubernetes-plugin

CMD ["/usr/bin/android-farm-kubernetes-plugin"]