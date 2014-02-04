"use strict"

myApp = angular.module("myApp", [])
  .config ($routeProvider) ->
    $routeProvider
      .when "/",
        templateUrl: "views/index.html"
        controller : "IndexController"
      .otherwise "/",
        redirectTo: "/"


