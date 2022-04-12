A build toolchain for Snyk Docker images.

![Build and push images](https://github.com/snyk/snyk-images/workflows/Build%20and%20push%20images/badge.svg) ![Generate Actions to build Snyk images](https://github.com/snyk/snyk-images/workflows/Generate%20Actions%20to%20build%20Snyk%20images/badge.svg)


## Design goals

* Make it easy to provide images which match upstream development environments, for example
  covering the range of different software versions and operating systems in common usage
* Minimize the amount of configuration we need to maintain per image
* Avoid the need to install a Node development environment for non-Node users
* Enable images to be automatically built (and rebuilt) regularly


## Images

## Current images

| Image | Based on |
| --- | --- |
| snyk/snyk:alpine | alpine |
| snyk/snyk:cocoapods | alpine |
| snyk/snyk:swift | alpine |
| snyk/snyk:clojure | clojure |
| snyk/snyk:clojure-boot | clojure:boot |
| snyk/snyk:clojure-lein | clojure:lein |
| snyk/snyk:clojure-tools-deps | clojure:tools-deps |
| snyk/snyk:composer | composer |
| snyk/snyk:php | composer |
| snyk/snyk:docker-18.09 | docker:18.09 |
| snyk/snyk:docker-19.03 | docker:19.03 |
| snyk/snyk:docker-latest | docker:latest |
| snyk/snyk:docker | docker:stable |
| snyk/snyk:golang | golang |
| snyk/snyk:golang-1.12 | golang:1.12 |
| snyk/snyk:golang-1.13 | golang:1.13 |
| snyk/snyk:golang-1.14 | golang:1.14 |
| snyk/snyk:golang-1.15 | golang:1.15 |
| snyk/snyk:golang-1.16 | golang:1.16 |
| snyk/snyk:golang-1.17 | golang:1.17 |
| snyk/snyk:golang-1.18 | golang:1.18 |
| snyk/snyk:gradle | gradle |
| snyk/snyk:gradle-6.4 | gradle:6.4 |
| snyk/snyk:gradle-6.4-jdk11 | gradle:6.4-jdk11 |
| snyk/snyk:gradle-6.4-jdk14 | gradle:6.4-jdk14 |
| snyk/snyk:gradle-6.4-jdk8 | gradle:6.4-jdk8 |
| snyk/snyk:gradle-jdk11 | gradle:jdk11 |
| snyk/snyk:gradle-jdk12 | gradle:jdk12 |
| snyk/snyk:gradle-jdk13 | gradle:jdk13 |
| snyk/snyk:gradle-jdk14 | gradle:jdk14 |
| snyk/snyk:gradle-jdk16 | gradle:jdk16 |
| snyk/snyk:gradle-jdk8 | gradle:jdk8 |
| snyk/snyk:sbt | hseeberger/scala-sbt:8u212_1.2.8_2.13.0 |
| snyk/snyk:scala | hseeberger/scala-sbt:8u212_1.2.8_2.13.0 |
| snyk/snyk:java | java |
| snyk/snyk:maven | maven |
| snyk/snyk:maven-3-jdk-11 | maven:3-jdk-11 |
| snyk/snyk:maven-3-jdk-12 | maven:3-jdk-12 |
| snyk/snyk:maven-3-jdk-13 | maven:3-jdk-13 |
| snyk/snyk:maven-3-jdk-14 | maven:3-jdk-14 |
| snyk/snyk:maven-3-openjdk-17 | maven:3-openjdk-17 |
| snyk/snyk:maven-3-jdk-8 | maven:3-jdk-8 |
| snyk/snyk:dotnet | mcr.microsoft.com/dotnet/core/sdk |
| snyk/snyk:dotnet-2.1 | mcr.microsoft.com/dotnet/core/sdk:2.1 |
| snyk/snyk:dotnet-2.2 | mcr.microsoft.com/dotnet/core/sdk:2.2 |
| snyk/snyk:dotnet-3.0 | mcr.microsoft.com/dotnet/core/sdk:3.0 |
| snyk/snyk:dotnet-3.1 | mcr.microsoft.com/dotnet/core/sdk:3.1 |
| snyk/snyk:node | node |
| snyk/snyk:node-10 | node:10 |
| snyk/snyk:node-12 | node:12 |
| snyk/snyk:node-13 | node:13 |
| snyk/snyk:node-14 | node:14 |
| snyk/snyk:node-8 | node:8 |
| snyk/snyk:python | python |
| snyk/snyk:python-2.7 | python:2.7 |
| snyk/snyk:python-3.6 | python:3.6 |
| snyk/snyk:python-3.7 | python:3.7 |
| snyk/snyk:python-3.8 | python:3.8 |
| snyk/snyk:python-3.9 | python:3.9-rc |
| snyk/snyk:python-alpine | python:alpine |
| snyk/snyk:ruby | ruby |
| snyk/snyk:ruby-2.4 | ruby:2.4 |
| snyk/snyk:ruby-2.5 | ruby:2.5 |
| snyk/snyk:ruby-2.6 | ruby:2.6 |
| snyk/snyk:ruby-2.7 | ruby:2.7 |
| snyk/snyk:ruby-alpine | ruby:alpine |
| snyk/snyk:linux | ubuntu |

### Usage

These images are published on Docker Hub at [snyk/snyk](https://hub.docker.com/r/snyk/snyk) See the toolchain instructions below if you want to build your own versions.

Usage requires a Snyk API token stored in an environment variable called `SNYK_TOKEN`.

I've picked a somewhat random example Golang respository which is setup to use Go Modules.

```console
$ git clone git@github.com:puppetlabs/wash.git
$ docker run --rm -it --env SNYK_TOKEN -v $(PWD):/app snyk/snyk:golang

Testing /app...

Organization:      garethr
Package manager:   gomodules
Target file:       go.mod
Open source:       no
Project path:      /app
Licenses:          enabled

✓ Tested 426 dependencies for known issues, no vulnerable paths found.

Next steps:
- Run `snyk monitor` to be notified about new related vulnerabilities.
- Run `snyk test` as part of your CI/test.
```

Here's another example, this time using a vulnerable Node.js application:

```console
$ git clone git@github.com:snyk/goof.git
$ docker run --rm -it --env SNYK_TOKEN -v $(PWD):/app snyk/snyk:node
...
✗ High severity vulnerability found in ejs
  Description: Arbitrary Code Execution
  Info: https://snyk.io/vuln/npm:ejs:20161128
  Introduced through: ejs@1.0.0, ejs-locals@1.0.2
  From: ejs@1.0.0
  From: ejs-locals@1.0.2 > ejs@0.8.8
  Remediation:
    Upgrade direct dependency ejs@1.0.0 to ejs@2.5.3 (triggers upgrades to ejs@2.5.3)
    Some paths have no direct dependency upgrade that can address this issue.

✗ High severity vulnerability found in dustjs-linkedin
  Description: Code Injection
  Info: https://snyk.io/vuln/npm:dustjs-linkedin:20160819
  Introduced through: dustjs-linkedin@2.5.0
  From: dustjs-linkedin@2.5.0
  Remediation:
    Upgrade direct dependency dustjs-linkedin@2.5.0 to dustjs-linkedin@2.6.0 (triggers upgrades to dustjs-linkedin@2.6.0)

✗ High severity vulnerability found in adm-zip
  Description: Arbitrary File Write via Archive Extraction (Zip Slip)
  Info: https://snyk.io/vuln/npm:adm-zip:20180415
  Introduced through: adm-zip@0.4.7
  From: adm-zip@0.4.7
  Remediation:
    Upgrade direct dependency adm-zip@0.4.7 to adm-zip@0.4.11 (triggers upgrades to adm-zip@0.4.11)



Organization:      garethr
Package manager:   npm
Target file:       package-lock.json
Open source:       no
Project path:      /app
Licenses:          enabled

Tested 448 dependencies for known issues, found 47 issues, 90 vulnerable paths.

```

### Testing Docker images

You can test Docker images as well by mounting the local Docker socket:

```
docker run --rm -it --env SNYK_TOKEN -v /var/run/docker.sock:/var/run/docker.sock snyk/snyk:docker snyk test --docker nginx
```

### Including Snyk in your own images

The easiest way of adding Snyk into your own custom images is to copy the binary from one of the above images. If you're using a `glibc` flavour of Linux (most of them) then add the following `COPY` line to your Dockerfile.

```dockerfile
FROM ubuntu

COPY --from=snyk/snyk:linux /usr/local/bin/snyk /usr/local/bin/snyk
```

If you're using a `musl` based distribution like Alpine then you need a different binary.

```dockerfile
FROM alpine

COPY --from=snyk/snyk:alpine /usr/local/bin/snyk /usr/local/bin/snyk
```

#### A note on Go dep support

Using [dep](https://github.com/golang/dep) requires a little bit of extra work, as determining the dependencies requires the source code to be on the `GOPATH`.
To test projects using dep you need to mount the source into the relevant `GOPATH` directory and pass the same path as the working directory. Here's an example.

```console
$ docker run --rm -it --env SNYK_TOKEN --workdir /go/src/hypnoglow/helm-s3 -v (pwd):/go/src/hypnoglow/helm-s3 snyk/snyk:golang
ARCH = amd64
OS = linux
Will install into /go/bin
Fetching https://github.com/golang/dep/releases/latest..
Release Tag = v0.5.4
Fetching https://github.com/golang/dep/releases/tag/v0.5.4..
Fetching https://github.com/golang/dep/releases/download/v0.5.4/dep-linux-amd64..
Setting executable permissions.
Moving executable to /go/bin/dep

Testing /go/src/hypnoglow/helm-s3...

Organization:      garethr
Package manager:   golangdep
Target file:       Gopkg.lock
Open source:       no
Project path:      /go/src/hypnoglow/helm-s3
Licenses:          enabled

✓ Tested 72 dependencies for known issues, no vulnerable paths found.

Next steps:
- Run `snyk monitor` to be notified about new related vulnerabilities.
- Run `snyk test` as part of your CI/test.
```


### Running bootstrap commands

In some cases you may want to run a command before Snyk tests your dependencies. This is not required for most development environments. For common cases the images do some pre-work, for instance:

* If Maven is installed and a `pom.xml` file is found, `mvn install` is run
* If Pip is present and a `requirements.txt` file is found, run `pip install -r requirements.txt`
* If Pipenv is present, run `pipenv sync` (if we find a `Pipfile.lock`) or `pipenv update` (if we find only a `Pipfile`)
* If `pyproject.toml` is present then run `poetry install`. Will install `poetry` if not already present

If you have specific requirements you can pass the command to run (which replaces any of the above) using the `COMMAND` environment variable. For instance, if you have a Python project with dependencies specified in a file called `dependencies.txt` you could run:

```
docker run --rm -it --env SNYK_TOKEN --env COMMAND="pip install -r dependencies.txt" -v $(PWD):/app snyk/snyk:python snyk test --file=dependencies.txt
```

By default the output for these bootstrap commands is not shown, so the output should just be that from Snyk. However if you're debugging an installation problem then you can pass the `DEBUG` environment variable to trigger the output from the intermediary commands.

```
docker run --rm -it --env SNYK_TOKEN --env DEBUG=1 -v $(PWD):/app snyk/snyk:python
```

## Toolchain

### Usage

When run, the `build` target will build an image for every parent image specified in both `linux` and `alpine` files. The only modifications made are to install the latest version of Snyk.

```
make build
```

Note that this requires a modern version of Docker with BuildKit enabled. You can do this in most cases by setting `export DOCKER_BUILDKIT=1`.


### Maintenance

Potentially the lists of images in `linux` and `alpine` could grow large, so keeping them in alphabetical order should help to maintain some semblance of order. The following command will sort both files.

```
make sort
```

As well as knowing the images build correctly it's useful to have a basic test suite. At present this is very minimal, mainly a demonstrating using [Structure Tests](https://github.com/GoogleContainerTools/container-structure-test). You don't need anything except Docker installed locally to run the tests.

```
make test
```
