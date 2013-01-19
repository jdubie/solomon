########################################
## Book MODEL
########################################
mongoose = require 'mongoose'

bookSchema = new mongoose.Schema
  title: String

module.exports = mongoose.model('Book', bookSchema)
