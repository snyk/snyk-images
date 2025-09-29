<!--
# +-----------------------------------------------+
# | WARNING: This file is generated, do not edit! |
# | Edit _templates/BASE.md.erb instead.          |
# +-----------------------------------------------+
-->

A build toolchain for Snyk Docker images.

## Design goals

* Make it easy to provide images which match upstream development environments, for example
  covering the range of different software versions and operating systems in common usage
* Minimize the amount of configuration we need to maintain per image
* Avoid the need to install a Node development environment for non-Node users
* Enable images to be automatically built (and rebuilt) regularly

## Images

### Current images

| Image                          | Based on                          |
|--------------------------------|-----------------------------------|
| snyk/snyk:clojure-boot         | clojure:boot                      |
| snyk/snyk:clojure-lein         | clojure:lein                      |
| snyk/snyk:clojure-tools-deps   | clojure:tools-deps                |
| snyk/snyk:elixir               | elixir                            |
| snyk/snyk:elixir-1.18          | elixir:1.18                       |
| snyk/snyk:golang               | golang                            |
| snyk/snyk:golang-1.23          | golang:1.23                       |
| snyk/snyk:golang-1.24          | golang:1.24                       |
| snyk/snyk:gradle               | gradle                            |
| snyk/snyk:gradle-8-jdk8        | gradle:8-jdk8                     |
| snyk/snyk:gradle-8-jdk11       | gradle:8-jdk11                    |
| snyk/snyk:gradle-8-jdk17       | gradle:8-jdk17                    |
| snyk/snyk:gradle-8-jdk21       | gradle:8-jdk21                    |
| snyk/snyk:gradle-8-jdk24       | gradle:8-jdk24                    |
| snyk/snyk:gradle-9-jdk17       | gradle:9-jdk17                    |
| snyk/snyk:gradle-9-jdk21       | gradle:9-jdk21                    |
| snyk/snyk:gradle-9-jdk24       | gradle:9-jdk24                    |
| snyk/snyk:maven                | maven                             |
| snyk/snyk:maven-3-jdk-8        | maven:3-eclipse-temurin-8         |
| snyk/snyk:maven-3-jdk-11       | maven:3-eclipse-temurin-11        |
| snyk/snyk:maven-3-jdk-17       | maven:3-eclipse-temurin-17        |
| snyk/snyk:maven-3-jdk-21       | maven:3-eclipse-temurin-21        |
| snyk/snyk:maven-3-jdk-24       | maven:3-eclipse-temurin-24        |
| snyk/snyk:maven-3-jdk-25       | maven:3-eclipse-temurin-25        |
| snyk/snyk:dotnet-8.0           | mcr.microsoft.com/dotnet/sdk:8.0  |
| snyk/snyk:dotnet-9.0           | mcr.microsoft.com/dotnet/sdk:9.0  |
| snyk/snyk:node                 | node                              |
| snyk/snyk:node-20              | node:20                           |
| snyk/snyk:node-22              | node:22                           |
| snyk/snyk:python               | python                            |
| snyk/snyk:python-3.9           | python:3.9                        |
| snyk/snyk:python-3.10          | python:3.10                       |
| snyk/snyk:python-3.11          | python:3.11                       |
| snyk/snyk:python-3.12          | python:3.12                       |
| snyk/snyk:ruby                 | ruby                              |
| snyk/snyk:ruby-3.3             | ruby:3.3                          |
| snyk/snyk:swift                | swift                             |
| snyk/snyk:linux                | ubuntu                            |
| snyk/snyk:sbt1.10.0-scala3.4.2 | sbtscala/scala-sbt:eclipse-temurin-jammy-22_36_1.10.0_3.4.2 |
| snyk/snyk:alpine               | alpine                            |
| snyk/snyk:cocoapods            | alpine                            |
| snyk/snyk:composer             | composer                          |
| snyk/snyk:php                  | composer                          |
| snyk/snyk:docker               | docker:latest                     |
| snyk/snyk:docker-latest        | docker:latest                     |
| snyk/snyk:python-alpine        | python:alpine                     |
| snyk/snyk:ruby-alpine          | ruby:alpine                       |


### Vendor unsupported base images
These images are no longer supported by the upstream vendor and should no longer be used, as such, the images below are no longer maintained. As a general practice, Snyk does not remove images once published. However, Snyk will not build or maintain images based on EoL software users of these images should move to a vendor-supported upstream image base immediately.

| Image                        | Based on                                |
|------------------------------|-----------------------------------------|
| snyk/snyk:docker-18.09       | docker:18.09                            |
| snyk/snyk:docker-19.03       | docker:19.03                            |
| snyk/snyk:elixir-1.10        | elixir:1.10                             |
| snyk/snyk:elixir-1.11        | elixir:1.11                             |
| snyk/snyk:elixir-1.12        | elixir:1.12                             |
| snyk/snyk:golang-1.12        | golang:1.12                             |
| snyk/snyk:golang-1.13        | golang:1.13                             |
| snyk/snyk:golang-1.14        | golang:1.14                             |
| snyk/snyk:golang-1.15        | golang:1.15                             |
| snyk/snyk:golang-1.16        | golang:1.16                             |
| snyk/snyk:golang-1.17        | golang:1.17                             |
| snyk/snyk:golang-1.18        | golang:1.18                             |
| snyk/snyk:golang-1.19        | golang:1.19                             |
| snyk/snyk:golang-1.20        | golang:1.20                             |
| snyk/snyk:golang-1.21        | golang:1.21                             |
| snyk/snyk:golang-1.22        | golang:1.22                             |
| snyk/snyk:gradle-6.4         | gradle:6.4                              |
| snyk/snyk:gradle-6.4-jdk11   | gradle:6.4-jdk11                        |
| snyk/snyk:gradle-6.4-jdk14   | gradle:6.4-jdk14                        |
| snyk/snyk:gradle-6.4-jdk8    | gradle:6.4-jdk8                         |
| snyk/snyk:gradle-jdk8        | gradle:jdk8                             |
| snyk/snyk:gradle-jdk11       | gradle:jdk11                            |
| snyk/snyk:gradle-jdk12       | gradle:jdk12                            |
| snyk/snyk:gradle-jdk13       | gradle:jdk13                            |
| snyk/snyk:gradle-jdk14       | gradle:jdk14                            |
| snyk/snyk:gradle-jdk16       | gradle:jdk16                            |
| snyk/snyk:gradle-jdk17       | gradle:jdk17                            |
| snyk/snyk:gradle-jdk18       | gradle:jdk18                            |
| snyk/snyk:gradle-jdk19       | gradle:jdk19                            |
| snyk/snyk:gradle-jdk20       | gradle:jdk20                            |
| snyk/snyk:gradle-jdk21       | gradle:jdk21                            |
| snyk/snyk:gradle-jdk23       | gradle:jdk23                            |
| snyk/snyk:gradle-jdk24       | gradle:jdk24                            |
| snyk/snyk:maven-3-jdk-19     | maven:3-eclipse-temurin-19              |
| snyk/snyk:maven-3-jdk-20     | maven:3-eclipse-temurin-20              |
| snyk/snyk:maven-3-jdk-22     | maven:3-eclipse-temurin-22              |
| snyk/snyk:dotnet             | mcr.microsoft.com/dotnet/core/sdk       |
| snyk/snyk:dotnet-2.1         | mcr.microsoft.com/dotnet/core/sdk:2.1   |
| snyk/snyk:dotnet-2.2         | mcr.microsoft.com/dotnet/core/sdk:2.2   |
| snyk/snyk:dotnet-3.0         | mcr.microsoft.com/dotnet/core/sdk:3.0   |
| snyk/snyk:dotnet-3.1         | mcr.microsoft.com/dotnet/core/sdk:3.1   |
| snyk/snyk:node-8             | node:8                                  |
| snyk/snyk:node-10            | node:10                                 |
| snyk/snyk:node-12            | node:12                                 |
| snyk/snyk:node-13            | node:13                                 |
| snyk/snyk:node-14            | node:14                                 |
| snyk/snyk:node-15            | node:15                                 |
| snyk/snyk:node-16            | node:16                                 |
| snyk/snyk:node-18            | node:18                                 |
| snyk/snyk:python-2.7         | python:2.7                              |
| snyk/snyk:python-3.6         | python:3.6                              |
| snyk/snyk:python-3.7         | python:3.7                              |
| snyk/snyk:python-3.8         | python:3.8                              |
| snyk/snyk:ruby-2.4           | ruby:2.4                                |
| snyk/snyk:ruby-2.5           | ruby:2.5                                |
| snyk/snyk:ruby-2.6           | ruby:2.6                                |
| snyk/snyk:ruby-2.7           | ruby:2.7                                |
| snyk/snyk:sbt                | hseeberger/scala-sbt:8u212_1.2.8_2.13.0 |
| snyk/snyk:scala              | hseeberger/scala-sbt:8u212_1.2.8_2.13.0 |


### Security
Please be advised, that the docker images disable git trusted directory checks for all
directories mounted or accessible within the docker image. Only mount directories into the
docker image that you trust.

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

A guide on adding Snyk into your own custom images can be found in the Snyk Docs under [User-defined custom images for CLI](https://docs.snyk.io/snyk-scm-ide-and-ci-cd-integrations/snyk-ci-cd-integrations/user-defined-custom-images-for-cli).

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

#### Note on using spaces in arguments
When using argument values that include spaces please wrap the whole command in quotes as well as the individual argument itself.

```console
$ docker run --rm -it --env SNYK_TOKEN -v $(PWD):/app snyk/snyk:golang 'snyk code test --project-name="My Project" --org=MyOrg'
```

#### `snyk/snyk:java` image
Following [the deprecation of the docker Java image](https://github.com/docker-library/openjdk/issues/505) and with a lack of an alternative image, we had to remove the Java image.

#### `snyk/snyk:maven` image
Following the deprecation of the docker OpenJDK images, we now build these images using the eclipse-termurin jdk.

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

## Contributing

To ensure the long-term stability and quality of this project, we are moving to a closed-contribution model effective August 2025. This change allows our core team to focus on a centralized development roadmap and rigorous quality assurance, which is essential for a component with such extensive usage.

All of our development will remain public for transparency. We thank the community for its support and valuable contributions.

## Getting Support

GitHub issues have been disabled on this repository as part of our move to a closed-contribution model. The Snyk support team does not actively monitor GitHub issues on any Snyk development project.

For help with Snyk products, please use the [Snyk support page](https://support.snyk.io/), which is the fastest way to get assistance.

Made with 💜 by Snyk

[cli-gh]: https://github.com/snyk/snyk 'Snyk CLI'
[cli-ref]: https://docs.snyk.io/snyk-cli/cli-reference 'Snyk CLI Reference documentation'
[snyk-docker-images]: https://hub.docker.com/r/snyk/snyk 'Snyk Docker Images'
