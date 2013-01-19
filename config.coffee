db = {}
mongoose = require 'mongoose'

db.connect = () ->
  mongoose.connect('mongodb://localhost/bible')
db.disconnect = () ->
  mongoose.disconnect()

exports.db = db
