########################################
## Chapter MODEL
########################################
mongoose = require 'mongoose'

chapterSchema = new mongoose.Schema
  number: Number

module.exports = mongoose.model('Chapter', chapterSchema)
