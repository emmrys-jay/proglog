CONFIG_PATH=${HOME}/.proglog/

.PHONY: init
init:
	mkdir -p ${CONFIG_PATH}

.PHONY: gencert
gencert:
	cfssl gencert \
            -initca test/ca-csr.json | cfssljson -bare ca
    
	cfssl gencert \
            -ca=ca.pem \
            -ca-key=ca-key.pem \
            -config=test/ca-config.json \
            -profile=server \
            test/server-csr.json | cfssljson -bare server
	mv *.pem *.csr ${CONFIG_PATH}

.PHONY: generate
generate:
	protoc api/v1/*.proto \
                --go_out=api/v1 \
                --go-grpc_out=api/v1 \
                --go_opt=paths=source_relative \
                --go-grpc_opt=paths=source_relative \
                --proto_path=api/v1

.PHONY: test
test:
	go test -race ./...