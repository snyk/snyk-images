NAME=$$(echo $@ | cut -d "-" -f 2)

default: build

build: sort build-linux build-alpine

check-buildkit:
ifndef DOCKER_BUILDKIT
	$(error You must enable Buildkit for Docker, by setting DOCKER_BUILDKIT=1)
endif

build-linux: check-buildkit
	@awk '{ print "docker build --build-arg IMAGE="$$1" -t snyk/snyk-"$$NF" ." | "/bin/sh"}' $(NAME)

build-alpine: check-buildkit
	@awk '{ print "docker build --target alpine --build-arg IMAGE="$$1" -t snyk/snyk-"$$NF" ." | "/bin/sh"}' $(NAME)

test: test-linux test-alpine

test-%: 
	@awk '{ print "echo Testing "$$NF"; docker run --rm -v $(CURDIR):/app -v /var/run/docker.sock:/var/run/docker.sock gcr.io/gcp-runtimes/container-structure-test test --image snyk/snyk-"$$NF" --config /app/tests.yaml" | "/bin/bash"}' $(NAME)

sort: sort-linux sort-alpine

sort-%:
	@sort $(NAME) -o $(NAME)

.PHONY: defaul build build-linux build-alpine check-buildkit sort sort-% test test-%
