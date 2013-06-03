########################################
## Book MODEL
########################################
mongoose = require 'mongoose'

bookSchema = new mongoose.Schema
  book: String
  slug: String

module.exports = mongoose.model('Book', bookSchema)
