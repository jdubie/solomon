should = require 'should'
config = require '../config'
goose = require '../goose'

modelKeys =
  book:    ['slug', 'book']
  chapter: ['slug', 'number']
  verse:   ['slug', 'number', 'body']

describe 'goose', ->
  
  before (ready) ->
    config.db.connect()
    ready()

  describe '#getBook', ->
    it 'should return correct fields', (done) ->
      goose.getBook book: 'genesis', (err, book) ->
        should.not.exist(err)
        book.should.have.keys(modelKeys.book)
        book.should.have.property('slug', 'genesis')
        book.should.have.property('book', 'Genesis')
        done()

  describe '#getBooks', ->
    it 'should return correct fields', (done) ->
      goose.getBooks {}, (err, books) ->
        should.not.exist(err)
        books.should.have.length 49 # TODO should actually be longer
        book = books[0]
        book.should.have.keys(modelKeys.book)
        done()

  describe '#getChapter', ->
    it 'should return correct fields', (done) ->
      goose.getChapter book: 'genesis', chapter: 1, (err, chapter) ->
        should.not.exist(err)
        chapter.should.have.keys(modelKeys.chapter)
        done()

  describe '#getChapters', ->
    it 'should return correct fields', (done) ->
      goose.getChapters book: 'genesis', (err, chapters) ->
        chapters.should.have.length 50
        done()

  describe '#getVerse', ->
    it 'should return correct fields', (done) ->
      goose.getVerse book: 'genesis', chapter: 1, verse: 1, (err, verse) ->
        verse.should.have.keys(modelKeys.verse)
        verse.should.have.property('slug', 'genesis_1_1')
        verse.should.have.property('number', 1)
        verse.should.have.property('body', 'In the beginning God created the heaven and the earth.')
        done()

  describe '#getVerses', ->
    it 'should return correct fields', (done) ->
      goose.getVerses book: 'genesis', chapter: 1, (err, verses) ->
        should.not.exist(err)
        verses.should.have.length 31
        verse = verses[0]
        verse.should.have.keys(modelKeys.verse)
        verse.should.have.property('slug', 'genesis_1_1')
        verse.should.have.property('number', 1)
        verse.should.have.property('body', 'In the beginning God created the heaven and the earth.')
        done()

  after (done) ->
    config.db.disconnect()
    done()
