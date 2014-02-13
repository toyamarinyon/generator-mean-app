directoryConfig =
  appSrc         : "app/src"
  appDist        : "app/dist"
  appStyleSheets : "/client/assets/stylesheets"

fileConfig =
  clientConfig: "#{directoryConfig.appSrc}/client/config/application.coffee"

module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json"),
    watch:
      options:
        livereload: true
      jade:
        files:
          directoryConfig.appSrc+"/**/*.jade"
        tasks:
          "jade"
      coffee:
        files:
          directoryConfig.appSrc+"/**/*.coffee"
        tasks:
          "coffee"
      sass:
        files:
          directoryConfig.appSrc+"/**/*.sass"
        tasks:
          "sass"
      image:
        files:
          directoryConfig.appSrc+"/**/*.png"
        tasks:
          "imagemin"

    jade:
      compile:
        options:
          pretty: true
          data: ->
            package: require("./package.json")
        files: [
          expand: true
          cwd  : directoryConfig.appSrc
          src  : "**/*.jade"
          dest : directoryConfig.appDist
          ext  : ".html"
        ]

    coffee:
      options:
        bare: true
      compile:
        files: [
          expand: true
          cwd  : directoryConfig.appSrc
          src  : "**/*.coffee"
          dest : directoryConfig.appDist
          ext  : ".js"
        ]

    compass:
      compile:
        options:
          require : "bootstrap-sass"
          bundleExec : true
          sassDir : "#{directoryConfig.appSrc}#{directoryConfig.appStyleSheets}"
          cssDir  : "#{directoryConfig.appDist}#{directoryConfig.appStyleSheets}"

    imagemin:
      png:
        options:
          optimizationLevel: 3
        files: [
          expand: true
          cwd: directoryConfig.appSrc
          src: "**/*.png"
          dest: directoryConfig.appDist
        ]

    nodemon:
      dev:
        options:
          file: 'server.js'
          args: []
          ignoredFiles: ['public/**']
          watchedExtensions: ['js']
          nodeArgs: ['--debug']
          delayTime: 1
          env:
              PORT: 3000
          cwd: __dirname


    concurrent:
      tasks: ["nodemon", "watch"]
      options:
        logConcurrentOutput: true
    

  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-jade"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-compass"
  grunt.loadNpmTasks "grunt-contrib-imagemin"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-concurrent"
  grunt.loadNpmTasks "grunt-nodemon"

  grunt.registerTask "build", [
    "config"
    "jade"
    "coffee"
    "compass"
    "imagemin"
  ]
  grunt.registerTask "default", ["build", "concurrent"]
  grunt.registerTask "config", "build client config from package.json", ->
    grunt.file.delete fileConfig.clientConfig
    config = """
             APPLICATION =
               NAME: "#{grunt.config("pkg").name}"
             """
    grunt.file.write fileConfig.clientConfig, config
