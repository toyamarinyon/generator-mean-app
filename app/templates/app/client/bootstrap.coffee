"use strict"

app = angular.module("<%= _.slugify(appName) %>", ['ngRoute'])
  .config ($routeProvider) ->
    $routeProvider
      .when "/",
        templateUrl: "views/index.html"
        controller : "IndexController"
      .otherwise "/",
        redirectTo: "/"
