# Grape Boilerplate

Welcome to my custom grape boilerplate, feel free to use it to start developing
a very basic ruby-base api using grape and jwt.

## Requirements

- Ruby 2.7.1 with bundler

## Setup

You can have Ruby installed at system-level, or you can use a version manager
like [rbenv](https://github.com/rbenv/rbenv) or [rvm](https://rvm.io/) and get
the required version installed.

```
# At project's root after clone
$ rbenv use
$ gem install bundle
$ bundle install
```
## Configurations

You will find a settings sample file inside `config/settings.yml.sample`,
just copy and remove the `.sample` part and replace the values inside to get
your app with the necessary configurations ready.

```
$ cp config/settings.sample.yml config/settings.yml
```

### JWT

You must generate a private and public key to sign your JWT Tokens in case
you're going to use this as an authentication method, place the keys paths
inside the settings file.

## Development

For convenience use the `guard` gem to ease your development workflow:

```
$ bundle exec guard
```

## Using Docker

You can run this app inside a standalone docker container:

```
$ docker build -t grape-boilerplate .
$ docker run -p 3000:3000 grape-boilerplate
```

Visit http://localhost:3000/ and you will see a response from the app.

You can use `docker-compose` to run the app as well:

```
$ docker-compose up
```

## Testing

Use `rake` to perform either linting and testing:

```
$ bundle exec rake test # testing only
$ bundle exec rake # will perform linting and testing
```

## API and routes

All the APIs inside this app are intended to be versioned, you can find a v1
example already up, tested and ready to be used, to see all the mounted APIs
use the rake task

```
$ bundle exec rake routes

      GET        /api/:version/hello
      *          /*path
```

## Documentation
WIP

## Running in production
WIP
