should = require 'should'
config = require '../config'
goose = require '../goose'

modelKeys =
  book: ['slug', 'book']
  #chapter: ['slug']
  #verse:

describe 'goose', ->
  
  before (ready) ->
    config.db.connect()
    ready()

  describe '#getBook', ->
    it 'should return correct fields', (done) ->
      goose.getBook slug: 'genesis', (err, book) ->
        should.not.exist(err)
        book = book.toJSON()
        book.should.have.keys(modelKeys.book)
        book.should.have.property('slug', 'genesis')
        book.should.have.property('book', 'Genesis')
        done()

  describe '#getBooks', ->
    it 'should return correct fields', (done) ->
      goose.getBooks {}, (err, books) ->
        should.not.exist(err)
        books.should.have.length 49 # TODO should actually be longer
        book = books[0].toJSON()
        book.should.have.keys(modelKeys.book)
        done()
 
  #exports.getChapter = ({slug, chapter}, callback) ->
  #  Verse.findOne {slug, chapter}, (err, verse) ->
  #    callback(err, verse)
  #
  #exports.getVerse   = ({book, chapter, verse}, callback) ->
  #  # TODO for API
  #
  #exports.getBooks = ({}, callback) ->
  #  Book.find {}, _id: 0, book: 1, slug: 1, (err, books) ->
  #    callback(null, books)
  #
  #exports.getChapters = ({book}, callback) ->
  #  Verse.find {slug: book}, (err, verses) ->
  #    chapters = verses.map (verse) -> verse.chapter
  #    chapters = _(chapters).sortBy(_.identity)
  #    chapters = _(chapters).uniq()
  #    chapters = chapters.map (chapter) ->
  #      {book, chapter, slug: "#{book}_#{chapter}"}
  #    callback(err, chapters)
  #
  #exports.getVerses = ({book, chapter}, callback) ->
  #  Verse
  #    .find({slug: book, chapter})
  #    .sort('verse')
  #    .exec (err, verses) ->
  #      verses = verses.map ({verse, body}) ->
  #        {slug: "#{book}_#{chapter}_#{verse}", body, chapter, verse, body}
  #        #{slug: "#{book}_#{chapter}_#{verse}", body, chapter}
  #      callback(err, verses)

  after (done) ->
    config.db.disconnect()
    done()
