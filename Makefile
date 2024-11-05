generate:
	protoc api/v1/*.proto \
                --go_out=api/v1 \
                --go-grpc_out=api/v1 \
                --go_opt=paths=source_relative \
                --go-grpc_opt=paths=source_relative \
                --proto_path=api/v1

test:
	go test -race ./...