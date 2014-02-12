"use strict"

app = angular.module(APPLICATION.NAME, ['ngRoute'])
  .config ($routeProvider) ->
    $routeProvider
      .when "/",
        templateUrl: "views/index.html"
        controller : "IndexController"
      .otherwise "/",
        redirectTo: "/"
