export project=$$(gcloud config get-value project)
export image=gcr.io/${project}/echo:1.0

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

gen: ## Stub proto
	protoc -I proto proto/echo.proto --descriptor_set_out=proto/echo_descriptor.pb --go_out=plugins=grpc:proto

build: ## Build docker image
	docker build -t ${image} .

sh: ## sh into image
	docker run -it ${image} sh

run: ## run image
	docker run -it -p 50051:50051 ${image}

push: ## push image
	docker push ${image}

deploy-endpoint: ## Deploy endpoint
	gcloud endpoints services deploy proto/echo_descriptor.pb manifest/api_config.yaml