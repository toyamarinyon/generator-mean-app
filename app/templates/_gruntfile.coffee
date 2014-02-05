directoryConfig =
  appSrc: 'app/src'
  appDist: 'app/dist'

fileConfig =
  clientConfig: "#{directoryConfig.appSrc}/client/config/application.coffee"

module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json'),
    watch:
      options:
        livereload: true
      jade:
        files:
          directoryConfig.appSrc+'/**/*.jade'
        tasks:
          'jade'
      coffee:
        files:
          directoryConfig.appSrc+'/**/*.coffee'
        tasks:
          'coffee'
      sass:
        files:
          directoryConfig.appSrc+'/**/*.sass'
        tasks:
          'sass'
      image:
        files:
          directoryConfig.appSrc+'/**/*.png'
        tasks:
          'imagemin'

    jade:
      compile:
        options:
          pretty: true
          data: ->
            require("./package.json")
        files: [
          expand: true
          cwd: directoryConfig.appSrc
          src: '**/*.jade'
          dest: directoryConfig.appDist
          ext: '.html'
        ]

    coffee:
      options:
        bare: true
      compile:
        files: [
          expand: true
          cwd: directoryConfig.appSrc
          src: '**/*.coffee'
          dest: directoryConfig.appDist
          ext: '.js'
        ]

    sass:
      compile:
        files: [
          expand: true
          cwd: directoryConfig.appSrc
          src: '**/*.sass'
          dest: directoryConfig.appDist
          ext: '.css'
        ]

    imagemin:
      png:
        options:
          optimizationLevel: 3
        files: [
          expand: true
          cwd: directoryConfig.appSrc
          src: '**/*.png'
          dest: directoryConfig.appDist
        ]
    

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-imagemin'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'build', [
    'config'
    'jade'
    'coffee'
    'sass'
    'imagemin'
  ]
  grunt.registerTask 'watching', ['watch']
  grunt.registerTask 'default', ['build']
  grunt.registerTask 'config', 'build client config from package.json', ->
    grunt.file.delete fileConfig.clientConfig
    config = """
             APPLICATION =
               NAME: "#{grunt.config('pkg').name}"
             """
    grunt.file.write fileConfig.clientConfig, config
