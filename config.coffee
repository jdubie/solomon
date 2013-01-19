########################################
## DB
db = {}
mongoose = require 'mongoose'

db.connect = () ->
  mongoose.connect('mongodb://localhost/bible')

db.disconnect = () ->
  mongoose.disconnect()
########################################


########################################
## Constants
exports.TEXT_ROOT = 'data'
exports.BOOK_IDS = [ 'genesis' ]
########################################

exports.db = db
