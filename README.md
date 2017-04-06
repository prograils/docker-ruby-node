# prograils/ruby-node:latest

Starting point for running Rails specs - includes ruby 2.3.3 and
node 6.10.1

## What's inside

The supplied `Dockerfile` will create an images for docker containers
with ruby and nodejs.

## Getting started

### Getting the image

```
$ docker pull prograils/ruby-node:2.3.3
```

### Running

```
$ docker run -t -i prograils/ruby-node:2.3.3
```

### Testing
```
$ bundle exec rspec
```


## References

* [Test Drive Your Dockerfiles with RSpec and ServerSpec](https://robots.thoughtbot.com/tdd-your-dockerfiles-with-rspec-and-serverspec)
