NAME=$$(echo $@ | cut -d "-" -f 2)

PREFIX = "snyk/snyk"

default: build

build: sort build-linux build-alpine

build-push: build-linux-push build-alpine-push

check-buildkit:
ifndef DOCKER_BUILDKIT
	$(error You must enable Buildkit for Docker, by setting DOCKER_BUILDKIT=1)
endif

build-linux: check-buildkit
	@awk '{ print "docker build --build-arg IMAGE="$$1" -t "$(PREFIX)":"$$NF" ." | "/bin/sh"}' $(NAME)

build-alpine: check-buildkit
	@awk '{ print "docker build --target alpine --build-arg IMAGE="$$1" -t "$(PREFIX)":"$$NF" ." | "/bin/sh"}' $(NAME)

test: test-linux test-alpine

test-%: 
	@awk '{ print "echo Testing "$$NF"; docker run --rm -v $(CURDIR):/app -v /var/run/docker.sock:/var/run/docker.sock gcr.io/gcp-runtimes/container-structure-test test --image "$(PREFIX)":"$$NF" --config /app/tests.yaml" | "/bin/bash"}' $(NAME)

sort: sort-linux sort-alpine

sort-%:
	@sort $(NAME) -o $(NAME)

markdown:
	@echo "| Image | Based on |"
	@echo "| --- | --- |"
	@cat linux alpine | sort | awk '{ print "| "$(PREFIX)":"$$NF" | "$$1" |" }'

push:
	@cat linux alpine | sort | awk '{ print "docker push "$(PREFIX)":"$$NF"" | "/bin/bash"}'

build-linux-push:
	@awk '{ print "docker build --build-arg IMAGE="$$1" -t "$(PREFIX)":"$$NF" . && docker push "$(PREFIX)":"$$NF" && docker rmi "$(PREFIX)":"$$NF"" | "/bin/sh"}' $(NAME)

build-alpine-push:
	@awk '{ print "docker build --target alpine --build-arg IMAGE="$$1" -t "$(PREFIX)":"$$NF" . && docker push "$(PREFIX)":"$$NF" && docker rmi "$(PREFIX)":"$$NF"" | "/bin/sh"}' $(NAME)


.PHONY: default build build-push build-linux build-linux-push build-alpine build-alpine-push check-buildkit sort sort-% test test-% markdown push
