# magic-eight-bar

This application is the final project for EECE-4520, Software Engineering I.
In short, the application helps you discover other bars you like in Boston, based on bars you've already been to.

This application is written in client-server artitecture.
The client is a [Single-Page-Application (SPA)](http://en.wikipedia.org/wiki/Single-page_application) written in JavaScript which queries the backend through a RESTful HTTP API.
The server is written in Ruby on Rails, and communicates via [JSON](http://en.wikipedia.org/wiki/JSON).

## Table of Contents.

- [Dependencies](#dependencies)
- [Development](#development)
- [Deployment](#deployment)
- [Backend](#backend)
- [Frontend](#frontend)

## Dependencies

- System packages
  - `ruby (2.0.*)`
  - `node (0.10.*)`
  - `docker (1.1.*)` -- only used for deployment
  - `mysql (5.*.*)`
  - `libmysqldevclient (5.*.*)`
- Ruby Gems:
  - `bundler (1.6.3)`
  - See `Gemfile.lock`
- Node Modules:
  - `bower (1.3.9)`
  - `grunt (0.4.5)`
  - See `package.json` and `bower.json` for the frontend and backend dependencies, respectively.

## Development

This section outlines the steps necessary to get the servers up and running.
After having installed the system dependecies listed above, run:

```bash
# Install all of the Ruby dependencies
$ bundle install --jobs 8

# Install the backend JavaScript dependencies
$ npm install

# Install the frontend JavaScript dependencies
$ bower install
```

Next, we'll get your database going.
Run the following code to get your schema up-to-date.

```bash
$ bundle exec rake db:create db:migrate
```

After the first time, just run `bundle exec rake db:migrate` to get it up to date.

After that, we need to seed the bars in the database.
Using rake, this is easy as:

```bash
$ bundle exec rake seed:bars
```

Finally, we need to build the JavaScript application before the server can generate the static pages.
Grunt, much like Ruby's `rake`, can help you with this.

```bash
$ grunt
```

To run the server, run the following command:

```bash
RAILS_ENV=development bundle exec unicorn_rails -l3000 -cconfig/unicorn.rb
```

Go to your browser, hit `localhost:3000`, and the app should be there.

## Deployment

Our application runs on EC2 -- Amazon's cloud-based hosting service.
To ensure that our app will run on almost any server, we use [Docker](https://docker.io).
Docker allows us to build the application right on our laptop, send it over to the server, and run it instantly.

Assuming you have our AWS credentials, building the Docker Image is easy as:

```bash
$ FOG_CREDENTIAL=magic_eight_bar bundle exec rake build:docker
```

This command should take 5-10 minutes to run (it's creating an entire isolated operating system, after all).
Once that command succeeds, export it to our EC2 instance by running, being sure to interpolate `$MY_SHA` with the current git sha:

```bash
$ docker save magic:$MY_SHA | gzip -c | ssh ec2-user@magic8.bar 'docker import - magic:$MY_SHA'
```

In short, this command exports the image, compresses it, and then performs a streaming import to the Docker server over SSH.
Finally, ssh into the instance to kill the old container and start a new one:

```bash
$ ssh ec2-user@magic8.bar
$ docker rm -f magic
$ docker run --name=magic -p 80:3000 -d magic:$MY_SHA bash -lc 'cd /app && source secrets && bundle exec unicorn_rails -l3000 -cconfig/unicorn.rb'
```

Upon visiting `magic8.bar` in your browser, you should see your changes.

Note that we do not store ANY production credentials in our codebase.
To obtain the credentials, you must obtain our AWS credentials from another team member, and retrieve the credentials file from `s3://magic-eight-bar/secrets`.
You should not need these credentials to develop locally.

## Backend

Like most Rails applications, the backend business logic is housed in `/app`.
It has the following subdirectories:

 Directory          | Contents
--------------------|---------
 `/app/models`      | Database models. All of these models inherit from `ActiveRecord::Base`. Class methods correspond to table-level queries, whereas instance methods correspond to row-lowel queries. These classes only hold database logic to promote portability.
 `/app/controllers` | HTTP controllers. Each method of these classes corresponds directly to an HTTP route, defined in `config/routes.rb`. These classes usually query the database to produce the HTTP responses.
 `/app/services`    | Miscellanous services that contain business logic to drive the application.

## Frontend

 The frontend is a Single-page-application that uses [`Aviator`](https://github.com/swipely/aviator) for routing and [`React`](https://github.com/facebook/react) for rendering views.
 The entire application lives in `/frontend/`, and it has the following subdirectories:

 Directory        | Contents
------------------|---------
 `/frontend/js`   | Vanilla JavaScript, code here interactis with routing through `Aviator`, or with the backend through asyrchonous HTTP requests using [`Reqwest`](https://github.com/ded/reqwest)
 `/frontend/jsx`  | The `React` views.
 `/frontend/less` | [`Less`](http://lesscss.org/) is a popular library that makes CSS a bit nicer to work with.
 `/frontend/html` | Static pages.
