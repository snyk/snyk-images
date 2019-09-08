An *experimental* build toolchain for Snyk Docker images.

![](https://github.com/garethr/snyk-images/workflows/Build%20and%20push%20images/badge.svg)


## Design goals

* Make it easy to provide images which match upstream development environments, for example
  covering the range of different software versions and operating systems in common usage
* Minimize the amount of configuration we need to maintain per image
* Avoid the need to install a Node development environment for non-Node users


## Images

Please note that the nuber of images is relatively small at present, and not all of them are expected to work. This is very much work-in-progress, but the following demonstrates how these images are intended to work.

## Current images

| Image | Based on |
| --- | --- |
| docker.pkg.github.com/garethr/snyk-images/snyk-composer | composer |
| docker.pkg.github.com/garethr/snyk-images/snyk-php | composer |
| docker.pkg.github.com/garethr/snyk-images/snyk-golang | golang |
| docker.pkg.github.com/garethr/snyk-images/snyk-golang:1.12 | golang:1.12 |
| docker.pkg.github.com/garethr/snyk-images/snyk-golang:1.13 | golang:1.13 |
| docker.pkg.github.com/garethr/snyk-images/snyk-gradle | gradle |
| docker.pkg.github.com/garethr/snyk-images/snyk-gradle:jdk11 | gradle:jdk11 |
| docker.pkg.github.com/garethr/snyk-images/snyk-gradle:jdk12 | gradle:jdk12 |
| docker.pkg.github.com/garethr/snyk-images/snyk-gradle:jdk8 | gradle:jdk8 |
| docker.pkg.github.com/garethr/snyk-images/snyk-sbt | hseeberger/scala-sbt:8u212_1.2.8_2.13.0 |
| docker.pkg.github.com/garethr/snyk-images/snyk-scala | hseeberger/scala-sbt:8u212_1.2.8_2.13.0 |
| docker.pkg.github.com/garethr/snyk-images/snyk-java | java |
| docker.pkg.github.com/garethr/snyk-images/snyk-maven:3-jdk-11 | maven:3-jdk-11 |
| docker.pkg.github.com/garethr/snyk-images/snyk-maven:3-jdk-12 | maven:3-jdk-12 |
| docker.pkg.github.com/garethr/snyk-images/snyk-maven:3-jdk-13 | maven:3-jdk-13 |
| docker.pkg.github.com/garethr/snyk-images/snyk-maven:3-jdk-14 | maven:3-jdk-14 |
| docker.pkg.github.com/garethr/snyk-images/snyk-maven:3-jdk-8 | maven:3-jdk-8 |
| docker.pkg.github.com/garethr/snyk-images/snyk-dotnet | mcr.microsoft.com/dotnet/core/sdk |
| docker.pkg.github.com/garethr/snyk-images/snyk-node | node |
| docker.pkg.github.com/garethr/snyk-images/snyk-node:10 | node:10 |
| docker.pkg.github.com/garethr/snyk-images/snyk-node:12 | node:12 |
| docker.pkg.github.com/garethr/snyk-images/snyk-node:8 | node:8 |
| docker.pkg.github.com/garethr/snyk-images/snyk-python | python |
| docker.pkg.github.com/garethr/snyk-images/snyk-python:2.7 | python:2.7 |
| docker.pkg.github.com/garethr/snyk-images/snyk-python:3.6 | python:3.6 |
| docker.pkg.github.com/garethr/snyk-images/snyk-python:3.7 | python:3.7 |
| docker.pkg.github.com/garethr/snyk-images/snyk-python:alpine | python:alpine |
| docker.pkg.github.com/garethr/snyk-images/snyk-ruby | ruby |
| docker.pkg.github.com/garethr/snyk-images/snyk-ruby:2.4 | ruby:2.4 |
| docker.pkg.github.com/garethr/snyk-images/snyk-ruby:2.5 | ruby:2.5 |
| docker.pkg.github.com/garethr/snyk-images/snyk-ruby:2.6 | ruby:2.6 |
| docker.pkg.github.com/garethr/snyk-images/snyk-ruby:alpine | ruby:alpine

### Usage

Note that images are not currently published to Docker Hub, so usage requires you to build the images locally at present. See the toolchain instructions below. You'll need your Snyk API token stored in an environment variable called `SNYK_TOKEN`.

I've picked a somewhat random example Golang respository which is setup to use Go Modules. 

```console
$ git clone git@github.com:puppetlabs/wash.git
$ docker run --rm -it --env SNYK_TOKEN -v $(PWD):/app docker.pkg.github.com/garethr/snyk-images/snyk-golang

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
$ docker run --rm -it --env SNYK_TOKEN -v $(PWD):/app docker.pkg.github.com/garethr/snyk-images/snyk-node
...
✗ High severity vulnerability found in ejs
  Description: Arbitrary Code Execution
  Info: https://snyk.io/vuln/npm:ejs:20161128
  Introduced through: ejs@1.0.0, ejs-locals@1.0.2
  From: ejs@1.0.0
  From: ejs-locals@1.0.2 > ejs@0.8.8
  Remediation:
    Upgrade direct dependency ejs@1.0.0 to ejs@2.5.3 (triggers upgrades to ejs@2.5.3)
    Some paths have no direct dependency upgrade that can address this issue. Run `snyk wizard` to explore remediation options.

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

Run `snyk wizard` to address these issues.
```

### Running bootstrap commands

In some cases you may want to run a command before Snyk tests your dependencies. This is not required for most development environments. For common cases the images do some pre-work, for instance:

* If Maven is installed and a `pom.xml` file is found, `mvn install` is run
* If Pip is present and a `requirements.txt` file is found, run `pip install -r requirements.txt`
* If Pipenv is present, run `pipenv sync` (if we find a `Pipfile.lock`) or `pipenv update` (if we find only a `Pipfile`)

If you have specific requirements you can pass the command to run (which replaces any of the above) using the `COMMAND` environment variable. For instance, if you have a Python project with dependencies specified in a file called `dependencies.txt` you could run:


```
docker run --rm -it --env SNYK_TOKEN --env COMMAND="pip install -r dependencies.txt" -v $(PWD):/app snyk/snyk-python snyk test --file=dependencies.txt
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

