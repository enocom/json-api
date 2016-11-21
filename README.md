# Json-Api

A simple set of JSON RESTful endpoints using the repository pattern and Rails engines.

## About

This app lives at [json-api.herokuapp.com](http://json-api.herokuapp.com) and responds to requests at `/api/movies`.

There are two things which make this otherwise plain app interesting:

1. Any interaction with ActiveRecord is hidden behind a repository interface. I have written about the rationale of doing this [here](http://commandercoriander.net/blog/2014/10/02/isolating-active-record/).
2. The app uses engines and has no `app` folder in the top level. For some context on why this is valuable, see the talk by Stephan Hagemann, [Component-based Architectures in Ruby and Rails](https://www.youtube.com/watch?v=-54SDanDC00). If you prefer reading about the topic, there is also [a book](https://leanpub.com/cbra).

For an introduction to how this app's API was written, see the post [here](http://commandercoriander.net/blog/2014/01/04/test-driving-a-json-api-in-rails/).

If you would like to practice using `curl` while interacting with the app, see the post [here](http://commandercoriander.net/blog/2014/01/11/curling-with-rails/).

## JavaScript Clients

See [here](https://github.com/enocom/angular_client) for an AngularJS client.
