To contribute, 

you need to update the `linux` and `alpine` files. The entries there should correspondent to a valid parent image and the 
associated tag.

Afterwards, please run `ruby build.rb` to generate the dev.yml anew. If you don't have ruby install you can also use a
docker container.
```bash
docker run -it --rm -v $(pwd):/app ruby:2.6-slim bash
$ cd /app && ruby build.rb
```

