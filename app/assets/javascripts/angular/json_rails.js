var app = angular.module("jsonRails", ["rails"]);

app.factory("Movie", function(railsResourceFactory) {
  return railsResourceFactory({ url: "/api/movies", name: "movie" });
});

app.controller("MovieCtrl", function($scope, Movie) {
  Movie.query().then(function(movies) {
    $scope.movies = movies;
  });
});
