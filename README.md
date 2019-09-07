An *experimental* build toolchain for Snyk Docker images.

## Design goals

* Make it easy to provide images which match upstream development environments, for example
  covering the range of different software versions and operating systems in common usage
* Minimize the ammount of configuration we need to maintain per image
* Avoid the need to install a Node development environment for non-Node users


## Images

Please note that the nuber of images is relatively small at present, and not all of them are expected to work. This is very much work-in-progress, but the following demonstrates some progress.

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

