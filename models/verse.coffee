########################################
## Verse MODEL
########################################
mongoose = require 'mongoose'

verseSchema = new mongoose.Schema
  number: Number
  body: String

module.exports = mongoose.model('Verse', verseSchema)
