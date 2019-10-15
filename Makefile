all: chat

chat:
	@echo "build ingress check server"
	go build -o  chat

image: 
	@echo "build docker image"
	docker build -t websocket-chat:latest -f Dockerfile .

