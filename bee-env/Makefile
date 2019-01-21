.PHONY: dist test build
VERSION = 1.0.0
DOCKER_IMAGE_NAME="sinlov/bee"

printInfo:
	@echo "Script Info version $(VERSION)\n"

image:
	bash build-docker.sh

help: printInfo
	@echo "make image ~> make this folder docker images as -> $(DOCKER_IMAGE_NAME)"