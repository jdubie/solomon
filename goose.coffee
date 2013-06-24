debug    = require 'debug'
mongoose = require 'mongoose'
_        = require 'underscore'
Verse    = require './models/verse'
Book     = require './models/book'

debug = debug('goose')

bookFields = _id: 0, __v: 0, index: 0

exports.getBook = ({book}, callback) ->
  Book.findOne({slug: book}, bookFields).lean().exec(callback)

exports.getBooks = ({}, callback) ->
  Book
    .find({}, bookFields)
    .sort('index')
    .lean()
    .exec(callback)

exports.getChapter = ({book, chapter}, callback) ->
  Verse.findOne {slug: book, chapter}, (err, verse) ->
    chapter =
      book: verse.book
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
      {book: verses[0].book, number: chapter, slug: "#{book}_#{chapter}"}
    callback(err, chapters)

exports.getVerse = ({book, chapter, verse}, callback) ->
  # _id: 0, verse: 1, slug: 1, chapter: 1, body: 1
  Verse.findOne {slug: book, chapter, verse}, (err, verseObj) ->
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
