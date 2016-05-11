# Divi - Rails API
Diviup Code Callenge is a todo rails api meant to be used with the [divi-frontend].

## Installation
```sh
$ git clone [git-repo-url] diviup-code-challenge
$ cd divi-frontend
$ bundle install
$ bundle exec rake db:create
$ bundle exec rake db:migrate
$ bundle exec rake db:seed
$ rails s
```

## Running Tests

This project was proudly constructed using TDD process. Rspec serves all unit tests; you can find all tests in the spec directory. Before running test make sure you are in the project's root directory.

```sh
$ cd diviup-code-challenge
$ bundle exec rake db:test:prepare
$ bundle exec rspec spec/
```

## Linting

This project uses Rubocop which enforces guidelines outlined in the community [Ruby Style Guide].

```sh
$ rubocop
```

## Consuming the API

#### Signup - users#create
```bash
curl -X POST -H "Content-Type: application/json" -d '{"user": {"email": "test@example.com", "password": "12341234", "password_confirmation": "12341234"}}' http://localhost:3000/api/users

>> {"user":{"id":14,"email":"test@example.com","created_at":"2016-05-11T15:58:58.352Z","updated_at":"2016-05-11T15:58:58.352Z","access_token":"c7xp1c2XJxUwsFWpjAay"}}
```

#### Login - sessions#create
```bash
curl -X POST -H "Content-Type: application/json" -d '{"email": "test@example.com", "password": "12341234"}' http://localhost:3000/api/login

>> {"user":{"id":14,"email":"test@example.com","created_at":"2016-05-11T15:58:58.352Z","updated_at":"2016-05-11T16:00:19.759Z","access_token":"sMB5bQs6yp4Td2DFibtY"}}
```

#### Create List - lists#create
```bash
curl -X POST -H "Content-type: application/json" -H "Authorization: sMB5bQs6yp4Td2DFibtY" -d '{ "list": { "title": "Test Title", "description": "blah blah blah blah blah blah blah" } }' http://localhost:3000/api/lists

>> {"list":{"id":34,"title":"Test Title","description":"blah blah blah blah blah blah blah","user":{"id":14,"email":"test@example.com","created_at":"2016-05-11T15:58:58.352Z","updated_at":"2016-05-11T16:00:19.759Z","access_token":"sMB5bQs6yp4Td2DFibtY"},"tasks":[]}}
```

#### Show List - lists#show
```bash
curl -X GET -H "Content-type: application/json" -H "Authorization: sMB5bQs6yp4Td2DFibtY" http://localhost:3000/api/lists/34

>> {"list":{"id":34,"title":"Test Title","description":"blah blah blah blah blah blah blah","user":{"id":14,"email":"test@example.com","created_at":"2016-05-11T15:58:58.352Z","updated_at":"2016-05-11T16:00:19.759Z","access_token":"sMB5bQs6yp4Td2DFibtY"},"tasks":[]}}
```

#### All Lists - lists#index
```bash
curl -X GET -H "Content-type: application/json" -H "Authorization: sMB5bQs6yp4Td2DFibtY" http://localhost:3000/api/lists/
```
Output is too large to display here, view an example [all lists json response]. 


#### Create Task - tasks#create
```bash
curl -X POST -H "Content-type: application/json" -H "Authorization: sMB5bQs6yp4Td2DFibtY" -d '{ "task": { "title": "Test Title", "description": "blah blah blah blah blah blah blah", "user_id": 14, "list_id": 34 } }' http://localhost:3000/api/tasks

>> {"task":{"id":331,"title":"Test Title","description":"blah blah blah blah blah blah blah","complete":false,"user":{"id":14,"email":"test@example.com","created_at":"2016-05-11T15:58:58.352Z","updated_at":"2016-05-11T16:00:19.759Z","access_token":"sMB5bQs6yp4Td2DFibtY"},"list":{"id":34,"title":"Test Title","description":"blah blah blah blah blah blah blah","user":{"id":14,"email":"test@example.com","created_at":"2016-05-11T15:58:58.352Z","updated_at":"2016-05-11T16:00:19.759Z","access_token":"sMB5bQs6yp4Td2DFibtY"},"tasks":[{"id":331,"title":"Test Title","description":"blah blah blah blah blah blah blah","complete":false}]}}}
```

#### Show Task - tasks#show
```bash
curl -X GET -H "Content-type: application/json" -H "Authorization: sMB5bQs6yp4Td2DFibtY" http://localhost:3000/api/tasks/331

>>{"task":{"id":331,"title":"Test Title","description":"blah blah blah blah blah blah blah","complete":false,"user":{"id":14,"email":"test@example.com","created_at":"2016-05-11T15:58:58.352Z","updated_at":"2016-05-11T16:00:19.759Z","access_token":"sMB5bQs6yp4Td2DFibtY"},"list":{"id":34,"title":"Test Title","description":"blah blah blah blah blah blah blah","user":{"id":14,"email":"test@example.com","created_at":"2016-05-11T15:58:58.352Z","updated_at":"2016-05-11T16:00:19.759Z","access_token":"sMB5bQs6yp4Td2DFibtY"},"tasks":[{"id":331,"title":"Test Title","description":"blah blah blah blah blah blah blah","complete":false}]}}}ali@mogad-H "Authorization: sMB5bQs6yp4Td2DFibtY" http://localhost:3000/api/tasks/331
{"task":{"id":331,"title":"Test Title","description":"blah blah blah blah blah blah blah","complete":false,"user":{"id":14,"email":"test@example.com","created_at":"2016-05-11T15:58:58.352Z","updated_at":"2016-05-11T16:00:19.759Z","access_token":"sMB5bQs6yp4Td2DFibtY"},"list":{"id":34,"title":"Test Title","description":"blah blah blah blah blah blah blah","user":{"id":14,"email":"test@example.com","created_at":"2016-05-11T15:58:58.352Z","updated_at":"2016-05-11T16:00:19.759Z","access_token":"sMB5bQs6yp4Td2DFibtY"},"tasks":[{"id":331,"title":"Test Title","description":"blah blah blah blah blah blah blah","complete":false}]}}}
```

#### All Tasks - tasks#index
```bash
curl -X GET -H "Content-type: application/json" -H "Authorization: sMB5bQs6yp4Td2DFibtY" http://localhost:3000/api/tasks/

```
Output is too large to display view an expample [all tasks json response]. 

# License
----

MIT


**Free Software**

   [divi-frontend]: <https://github.com/alimfree/divi-frontend>
   [Ruby Style Guide]: <https://github.com/bbatsov/ruby-style-guide>
   [all lists json response]: <http://jsonblob.com/57335843e4b01190df649958>
   [all tasks json response]: <http://jsonblob.com/57335c1de4b01190df649a7e>
 