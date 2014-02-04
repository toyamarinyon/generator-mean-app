"use strict"

# Load Enviroment
enviroment = require("#{__dirname}/env/#{process.env.NODE_ENV}")

module.exports =
  root: require("path").normalize "#{__dirname}/../.."
  port: process.env.PORT || 3000
  hostname: enviroment.hostname
  db: enviroment.db
  clientDirectory: "/app/dist/client"

  # The secres should be set to a non-guessable string that
  # is used to compute a session hash
  sessionSecret: '8Ahs2j@ja'

  # The name of the MongoDB collection to store sessions in
  sessionCollection: 'sessions'