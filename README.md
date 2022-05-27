[![Continuous Integration](https://github.com/joalbertg/homie-challenge/actions/workflows/build_with_tests_and_linters.yml/badge.svg?branch=main)](https://github.com/joalbertg/homie-challenge/actions/workflows/build_with_tests_and_linters.yml)

# Homie Backend Challenge

Heroku: [health_check](https://homie-technical-challenge.herokuapp.com/health_check)

## Entity-relationship model

## QuickStart

### Configuration

* Ruby version: `3.1.1`
* Rails version: `7.0.3`

### Build project

```shell
docker compose build api
```

### Create database

```shell
docker compose run --rm api rails db:create
```

### Initialize database

```shell
docker compose run --rm api rails db:migrate
```

### Local deployment

```shell
docker compose up
```
## Health check

> go to link `localhost:3000/health_check`

## Deploy on Heroku (only on main branch)

- create the next secrets in the repository

```shell
secrets.HEROKU_API_KEY
secrets.HEROKU_API_APP
secrets.HEROKU_API_EMAIL
```

- create an app on Heroku

```shell
heroku create --region us <APP-NAME>
```

- copy the `<APP-NAME>` to `HEROKU_API_APP`
- create authorizations

```shell
heroku authorizations:create
```

- copy the Token to `HEROKU_API_KEY`
- copy your heroku account email to `HEROKU_API_EMAIL`

## Workflow

<p align="center">
  <kbd>
    <img src="miscellaneous/images/workflow_ci_cd.png" title="workflow">
  </kbd>
</p>
