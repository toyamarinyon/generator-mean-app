"use strict"

###
Module dependencies
###

mongoose = require("mongoose")
Schema   = mongoose.Schema

###
User Schema
###

UserSchema = new Schema
  name:
    type: String
    unique: true
    index: true
  provider: String
  facebook: {}
  guest: {}
  created_at: Date

###
Pre-save hook
###

UserSchema.pre "save", (next) ->
  return next() if !this.isNew
  this.created_at = new Date()
  next()

mongoose.model "User", UserSchema
