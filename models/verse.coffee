########################################
## Verse MODEL
########################################
mongoose = require 'mongoose'

verseSchema = new mongoose.Schema
  book: String
  chapter: Number
  verse: Number
  body: String
  slug: String

verseSchema.methods.toSolr = () ->
  id          : @_id
  book_s      : @book
  chapter_i   : @chapter
  verse_i     : @verse
  description : @body

module.exports = mongoose.model('Verse', verseSchema)
