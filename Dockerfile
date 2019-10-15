FROM registry.cn-hangzhou.aliyuncs.com/knative-sample/golang:1.12 as builder

# Copy local code to the container image.
WORKDIR /go/src/github.com/knative-sample/websocket-chat
COPY . ./

# Build the command inside the container.
# To facilitate gRPC testing, this container includes a client command.
RUN CGO_ENABLED=0 go build -tags=grpcping -o ./chat

FROM registry.cn-hangzhou.aliyuncs.com/knative-sample/alpine-sh:3.9

# Copy the binaries to the production image from the builder stage.
COPY --from=builder /go/src/github.com/knative-sample/websocket-chat/chat /chat
COPY --from=builder /go/src/github.com/knative-sample/websocket-chat/home.html /home.html

# Run the service on container startup.
CMD ["/chat"]
