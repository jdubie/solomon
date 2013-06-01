debug    = require 'debug'
mongoose = require 'mongoose'
_        = require 'underscore'

schema = new mongoose.Schema({ book: 'string', chapter: 'number', verse: 'number', body: 'string' })
Verse = mongoose.model('Verse', schema)

exports.getBook = ({book}, callback) ->
  Verse.findOne {book}, (err, verse) ->
    callback(err, verse)

exports.getChapter = ({book, chapter}, callback) ->
  Verse.findOne {book, chapter}, (err, verse) ->
    callback(err, verse)

exports.getVerse   = ({book, chapter, verse}, callback) ->
  # TODO for API

exports.getBooks = ({}, callback) ->
  Verse.find {}, (err, verses) ->
    books = verses.map (verse) -> verse.book
    books = _(books).uniq()
    books = books.map (book) ->
      slug: book.toLowerCase()
      book: book.toUpperCase()[0] + book[1..]
    callback(err, books)

exports.getChapters = ({book}, callback) ->
  Verse.find {book}, (err, verses) ->
    chapters = verses.map (verse) -> verse.chapter
    chapters = _(chapters).sortBy(_.identity)
    chapters = _(chapters).uniq()
    chapters = chapters.map (chapter) ->
      {book, chapter, slug: "#{book}_#{chapter}"}
    callback(err, chapters)

exports.getVerses = ({book, chapter}, callback) ->
  Verse
    .find({book, chapter})
    .sort('verse')
    .exec (err, verses) ->
      verses = verses.map ({verse, body}) ->
        {slug: "#{book}_#{chapter}_#{verse}", body, chapter, verse, body}
        #{slug: "#{book}_#{chapter}_#{verse}", body, chapter}
      callback(err, verses)
