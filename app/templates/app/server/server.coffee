###
Module dependencies.
###

express  = require("express")
fs       = require("fs")
passport = require("passport")
logger   = require("mean-logger")
io       = require("socket.io")


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

# Bootstrap models
require("./models")

# Bootstrap passport config
require("./config/passport")(passport)

# Bootstrap routes
require("./config/routes")
require("./config/sockets")

# Create Express
app = express()

# Hook Socket.io into Express
io.listen(app)

# Express settings
require("./config/express")(app, passport, db, config)

# Start the app by listening on <port>
port = process.env.PORT || config.port
app.listen port
console.log "Express app started on port " + port

# Socket.io Communication
io.sockets.on("connection", socket)

# Initializing logger
logger.init app, passport, mongoose

# Expose app
exports = module.exports = app
