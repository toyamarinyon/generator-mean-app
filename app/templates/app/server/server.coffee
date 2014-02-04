###
Module dependencies.
###

express  = require("express")
fs       = require("fs")
passport = require("passport")
logger   = require("mean-logger")


###
Main application entry file.
Please note that the order of loading is important.
###

# Load configurations
# Set the node enviroment variable if not set before
process.env.NODE_ENV = process.env.NODE_ENV || "development"

# Initializing system variables
config   = require("./config/common")
mongoose = require("mongoose")

# Bootstrap db connection
db = mongoose.connect config.db

# Bootstrap passport config
require("./config/passport")(passport)

# Create Express
app = express()

# Express settings
require("./config/express")(app, passport, db)

# Start the app by listening on <port>
port = process.env.PORT || config.port;
app.listen port
console.log "Express app started on port " + port

# Initializing logger
logger.init app, passport, mongoose

# Expose app
exports = module.exports = app
