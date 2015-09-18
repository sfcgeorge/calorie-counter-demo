# Calorie Counter Demo

An example app to demonstrate my knowledge of backend APIs and frontend single page apps consuming JSON.

Backend:

* RailsAPI
* Warden (authentication)
* Pundit (authorization, e.g user VS admin)

Frontend:

* Angular.JS
* CoffeeScript

Testing:

* RSpec

It uses HTTP basic auth to the /users/login endpoint which returns a token. The token is then used to authenticate all further requests with a similar HTTP token auth header.

## Run

```
bundle install
bundle exec rake db:setup
bundle exec rails s
```

Then visit ` http://localhost:3000` in your browser.

Sample login:

```
http://localhost:3000/#/login
Admin Username: Kai
Standard Username: Kash
Password: Password1
```

## Notes

If this were a real project several modifications should be made:

* Postgres / MySQL instead of SQLite
* Frontend validations
* Custom frontend styles
* Frontend tests
