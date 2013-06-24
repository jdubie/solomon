########################################
## Book MODEL
########################################
mongoose = require 'mongoose'

bookSchema = new mongoose.Schema
  book: String
  slug: String
  index: Number
  test: String
  klass: String

module.exports = mongoose.model('Book', bookSchema)
