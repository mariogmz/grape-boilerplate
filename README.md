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

### ENV vars

Configuration can be defined using environment variables, these will be
available through the `Settings` object but need to be defined using the
following syntax:

```
SETTINGS__LOGS__PATH="tmp/logs"
```

Using double "_" between namespaces and with the `SETTINGS` prefix, these
have precedence over the values defined inside `config/settings.yml`, this
a way to configure settings when deployed to Heroku.

### JWT

You must generate a private and public key to sign your JWT Tokens in case
you're going to use this as an authentication method, place the keys paths
inside the settings file.

For ENV based environments you can set an ENV variable to set keys values
to sign Tokens, thought this is not recommended it can help to use keys in
enviroments like Heroku where you can't access the key file itself.

```
SETTINGS__JWT__PRIVATE_KEY="your private key here"
SETTINGS__JWT__PUBLIC_KEY="your public key here"
```

## Development

For convenience use the `guard` gem to ease your development workflow:

```
$ bundle exec guard
```

Otherwise the `bundle exec rackup` command should just work fine, reloading
is needed after any changes to code.

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
      POST       /api/login
      *          /*path
```

## Documentation

Project's documentation is generated using swagger, a GET to `/swagger_doc`
should display a valid JSON to use inside [Swagger UI](https://editor.swagger.io/)
