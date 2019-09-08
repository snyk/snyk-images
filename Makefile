NAME=$$(echo $@ | cut -d "-" -f 2)

default: build

build: sort build-linux build-alpine

check-buildkit:
ifndef DOCKER_BUILDKIT
	$(error You must enable Buildkit for Docker, by setting DOCKER_BUILDKIT=1)
endif

build-linux: check-buildkit
	@awk '{ print "docker build --build-arg IMAGE="$$1" -t docker.pkg.github.com/garethr/snyk-"$$NF" ." | "/bin/sh"}' $(NAME)

build-alpine: check-buildkit
	@awk '{ print "docker build --target alpine --build-arg IMAGE="$$1" -t docker.pkg.github.com/garethr/snyk-"$$NF" ." | "/bin/sh"}' $(NAME)

test: test-linux test-alpine

test-%: 
	@awk '{ print "echo Testing "$$NF"; docker run --rm -v $(CURDIR):/app -v /var/run/docker.sock:/var/run/docker.sock gcr.io/gcp-runtimes/container-structure-test test --image docker.pkg.github.com/garethr/snyk-"$$NF" --config /app/tests.yaml" | "/bin/bash"}' $(NAME)

sort: sort-linux sort-alpine

sort-%:
	@sort $(NAME) -o $(NAME)

markdown:
	@echo "| Image | Based on |"
	@echo "| --- | --- |"
	@cat linux alpine | sort | awk '{ print "| docker.pkg.github.com/garethr/snyk-"$$NF" | "$$1" |" }'

push:
	@cat linux alpine | sort | awk '{ print "docker push docker.pkg.github.com/garethr/snyk-"$$NF"" | "/bin/bash"}'


.PHONY: defaul build build-linux build-alpine check-buildkit sort sort-% test test-% markdown push
