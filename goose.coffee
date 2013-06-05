debug    = require 'debug'
mongoose = require 'mongoose'
_        = require 'underscore'
Verse    = require './models/verse'
Book     = require './models/book'


exports.getBook = ({book}, callback) ->
  Book.findOne {slug: book}, _id: 0, slug: 1, book: 1, (err, verse) ->
    callback(err, verse.toJSON())

exports.getBooks = ({}, callback) ->
  Book.find {}, _id: 0, book: 1, slug: 1, (err, books) ->
    books = books.map (book) -> book.toJSON()
    callback(null, books)

exports.getChapter = ({book, chapter}, callback) ->
  Verse.findOne {slug: book, chapter}, (err, verse) ->
    chapter =
      slug:  "#{verse.slug}_#{verse.chapter}"
      number: verse.chapter
    callback(err, chapter)

# TODO this is reallly slow
exports.getChapters = ({book}, callback) ->
  Verse.find {slug: book}, (err, verses) ->
    chapters = verses.map (verse) -> verse.chapter
    chapters = _(chapters).sortBy(_.identity)
    chapters = _(chapters).uniq()
    chapters = chapters.map (chapter) ->
      {number: chapter, slug: "#{book}_#{chapter}"}
    callback(err, chapters)

exports.getVerse = ({book, chapter, verse}, callback) ->
  # _id: 0, verse: 1, slug: 1, chapter: 1, body: 1
  Verse.findOne {book, chapter, verse}, (err, verseObj) ->
    _verse =
      slug: "#{book}_#{chapter}_#{verse}"
      number: verse
      body: verseObj.body
    callback(err, _verse)

exports.getVerses = ({book, chapter}, callback) ->
  Verse
    .find({slug: book, chapter})
    .sort('verse')
    .exec (err, verses) ->
      verses = verses.map ({verse, body}) ->
        {slug: "#{book}_#{chapter}_#{verse}", number: verse, body}
      callback(err, verses)
