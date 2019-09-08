An *experimental* build toolchain for Snyk Docker images.

## Design goals

* Make it easy to provide images which match upstream development environments, for example
  covering the range of different software versions and operating systems in common usage
* Minimize the ammount of configuration we need to maintain per image
* Avoid the need to install a Node development environment for non-Node users


## Images

Please note that the nuber of images is relatively small at present, and not all of them are expected to work. This is very much work-in-progress, but the following demonstrates how these images are intended to work.

## Existing images

| Image | Based on |
| --- | --- |
| snyk/snyk-composer | composer |
| snyk/snyk-php | composer |
| snyk/snyk-golang | golang |
| snyk/snyk-gradle | gradle |
| snyk/snyk-sbt | hseeberger/scala-sbt:8u212_1.2.8_2.13.0 |
| snyk/snyk-scala | hseeberger/scala-sbt:8u212_1.2.8_2.13.0 |
| snyk/snyk-java | java |
| snyk/snyk-maven | maven |
| snyk/snyk-dotnet | mcr.microsoft.com/dotnet/core/sdk |
| snyk/snyk-node | node |
| snyk/snyk-python | python |
| snyk/snyk-python:alpine | python:alpine |
| snyk/snyk-ruby | ruby |
| snyk/snyk-ruby:alpine | ruby:alpine |

### Usage

Note that images are not currently published to Docker Hub, so usage requires you to build the images locally at present. See the toolchain instructions below. You'll need your Snyk API token stored in an environment variable called `SNYK_TOKEN`.

I've picked a somewhat random example Golang respository which is setup to use Go Modules. 

```console
$ git clone git@github.com:puppetlabs/wash.git
$ docker run --rm -it --env SNYK_TOKEN -v (pwd):/app snyk/snyk-golang

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
$ docker run --rm -it --env SNYK_TOKEN -v (pwd):/app snyk/snyk-node
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

