To contribute, you need to update the `linux` and `alpine` files. The entries there should correspondent to a valid
parent image and the associated tag.

Afterward, please run `ruby build.rb` to generate the dev.yml anew. If you don't have ruby install you can also use a
docker container.

```bash
docker run -it --rm -v $(pwd):/app ruby:2.6-slim bash
$ cd /app && ruby build.rb
```

## Which images can I add?

New base images can be added if they satisfy the following requirements:

* Are maintained by a well-known organization and meet
  the [trusted content](https://docs.docker.com/docker-hub/repos/manage/trusted-content/) criteria.
* Both the Docker base image and the added software are actively supported and have not reached their end of support.

## Which images can I remove?

Existing images can be deprecated if their base image or software has reached end of support.

Deprecation means they will be listed as deprecated in the [README](README.md) and will no longer be built or pushed to
Docker Hub.
