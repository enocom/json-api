describe("listing movies", function() {
  var createController, $httpBackend, $rootScope;

  beforeEach(module("jsonRails"));
  beforeEach(inject(function($injector) {
    $httpBackend = $injector.get("$httpBackend");
    $httpBackend.when("GET", "/api/movies").respond(
      [{ title: "A New Hope" }, { title: "The Empire Strikes Back" }]
    );

    $rootScope = $injector.get("$rootScope");
    var $controller = $injector.get("$controller");

    createController = function() {
      return $controller("MovieListCtrl", { "$scope": $rootScope });
    };
  }));

  it("retrieves all the movies", function() {
    $httpBackend.expectGET("/api/movies");
    var controller = createController();
    $httpBackend.flush();
    var firstMovieTitle = $rootScope.moviesList[0].title;
    var secondMovieTitle = $rootScope.moviesList[1].title;

    expect(firstMovieTitle).toEqual("A New Hope");
    expect(secondMovieTitle).toEqual("The Empire Strikes Back");
  });
});
