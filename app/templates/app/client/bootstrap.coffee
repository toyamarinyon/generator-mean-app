"use strict"

app = angular.module(APPLICATION.NAME, [])
  .config ($routeProvider) ->
    $routeProvider
      .when "/",
        templateUrl: "views/index.html"
        controller : "IndexController"
      .otherwise "/",
        redirectTo: "/"
