var app = angular.module("jsonRails", ["rails"]);

//app.config(function($httpProvider) {
//  var authToken = $("meta[name=\"csrf-token\"]").attr("content");
//  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken;
//});

app.factory("Movie", function(railsResourceFactory) {
  return railsResourceFactory({ url: "/api/movies", name: "movie" });
});

app.controller("MoviesCtrl", function($scope, Movie) {
  Movie.query().then(function(movies) {
    $scope.movies = movies;
  });
});
