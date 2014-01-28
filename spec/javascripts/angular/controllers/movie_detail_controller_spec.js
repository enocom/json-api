describe("movie details", function() {
  var createController, $httpBackend, $rootScope;

  beforeEach(module("jsonRails"));
  beforeEach(inject(function($injector) {
    $httpBackend = $injector.get("$httpBackend");
    $httpBackend.when("GET", "/api/movies/1").respond(
      { title: "A New Hope", director: "George Lucas" }
    );

    $rootScope = $injector.get("$rootScope");
    var $controller = $injector.get("$controller");

    createController = function(routeParams) {
      return $controller("MovieDetailCtrl", { "$scope" : $rootScope,
      "$routeParams" : routeParams });
    };
  }));

  it("retrieves a particular movie", function() {
    $httpBackend.expectGET("/api/movies/1");
    var controller = createController({ id: 1 });
    $httpBackend.flush();
    expect($rootScope.movie.title).toEqual("A New Hope");
    expect($rootScope.movie.director).toEqual("George Lucas");
  });
});
