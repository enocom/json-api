var app = angular.module("jsonRails", [
    "rails",
    "ngRoute"
]);

//app.config(function($httpProvider) {
//  var authToken = $("meta[name=\"csrf-token\"]").attr("content");
//  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken;
//});

app.factory("Movie", function(railsResourceFactory) {
  return railsResourceFactory({ url: "/api/movies", name: "movie" });
});

app.controller("MovieDetailCtrl", function($routeParams, $scope, Movie) {
  Movie.get($routeParams.id).then(function(movie) {
    $scope.movie = movie;
  });
});

app.controller("MovieListCtrl", function($scope, Movie) {
  Movie.query().then(function(movies) {
    $scope.moviesList = movies;
  });
});

app.config(function($routeProvider) {
  $routeProvider
  .when("/movies", {
    templateUrl: "movie_list.html",
    controller: "MovieListCtrl"
  })
  .when("/movies/:id", {
    templateUrl: "movie_detail.html",
    controller: "MovieDetailCtrl"
  });
});
