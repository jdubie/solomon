########################################
## Verse MODEL
########################################
mongoose = require 'mongoose'

verseSchema = new mongoose.Schema
  book: String
  chapter: Number
  verse: Number
  body: String

module.exports = mongoose.model('Verse', verseSchema)
