"use strict"

###
Module dependencies.
###
express    = require('express')
mongoStore = require('connect-mongo')(express)
flash      = require('connect-flash')
helpers    = require('view-helpers')
config     = require('./config')

module.exports = (app, passport, db) ->
  app.set 'showStackError', true

  # Prettify HTML
  app.locals.pretty = true

  # Should be placed before express.static
  # To ensure that all assets and data are compressed (utilize bandwidth)
  app.use express.compress
    filter: (req, res) ->
      /json|text|javascript|css/.test res.getHeader 'Content-Type'

    # Levels are specified in a range of 0 to 9, where-as 0 is
    # no compression and 9 is best compression, but slowest
    level: 9


  # Only use logger for development enviroment
  app.use express.logger 'dev' if process.env.NODE_ENV is 'development'
