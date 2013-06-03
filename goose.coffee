debug    = require 'debug'
mongoose = require 'mongoose'
_        = require 'underscore'
Verse    = require './models/verse'
Book     = require './models/book'


exports.getBook = ({slug}, callback) ->
  Book.findOne {slug}, (err, verse) ->
    callback(err, verse)

exports.getChapter = ({book, chapter}, callback) ->
  Verse.findOne {book, chapter}, (err, verse) ->
    callback(err, verse)

exports.getVerse   = ({book, chapter, verse}, callback) ->
  # TODO for API

exports.getBooks = ({}, callback) ->
  Book.find {}, _id: 0, book: 1, slug: 1, (err, books) ->
    callback(null, books)

exports.getChapters = ({book}, callback) ->
  Verse.find {slug: book}, (err, verses) ->
    chapters = verses.map (verse) -> verse.chapter
    chapters = _(chapters).sortBy(_.identity)
    chapters = _(chapters).uniq()
    chapters = chapters.map (chapter) ->
      {book, chapter, slug: "#{book}_#{chapter}"}
    callback(err, chapters)

exports.getVerses = ({book, chapter}, callback) ->
  Verse
    .find({slug: book, chapter})
    .sort('verse')
    .exec (err, verses) ->
      verses = verses.map ({verse, body}) ->
        {slug: "#{book}_#{chapter}_#{verse}", body, chapter, verse, body}
        #{slug: "#{book}_#{chapter}_#{verse}", body, chapter}
      callback(err, verses)
