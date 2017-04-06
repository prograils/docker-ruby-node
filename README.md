# prograils/ruby-node:latest

Starting point for running Rails specs - includes lastest stable ruby and
node 6.10.1

## What's inside

The supplied `Dockerfile` will create an images for docker containers
with ruby and nodejs.

## Getting started

### Getting the image

```
$ docker pull prograils/ruby-node
```

### Running

```
$ docker run -t -i prograils/ruby-node
```

### Testing
```
$ bundle exec rspec
```


## References

* [Test Drive Your Dockerfiles with RSpec and ServerSpec](https://robots.thoughtbot.com/tdd-your-dockerfiles-with-rspec-and-serverspec)
