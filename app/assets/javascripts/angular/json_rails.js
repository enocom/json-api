var app = angular.module("jsonRails", ["rails", "ngRoute"]);

//app.config(function($httpProvider) {
//  var authToken = $("meta[name=\"csrf-token\"]").attr("content");
//  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken;
//});

//app.config(function($routeProvider) {
//  $routeProvider
//  .when("/movies/:id", {
//    templateUrl: "",
//    controller: "MoviesCtrl"
//  });
//});

app.factory("Movie", function(railsResourceFactory) {
  return railsResourceFactory({ url: "/api/movies", name: "movie" });
});

app.controller("MovieListCtrl", function($scope, Movie) {
  Movie.query().then(function(movies) {
    $scope.movies = movies;
  });
});
