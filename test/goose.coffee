should = require 'should'
config = require '../config'
goose = require  '../goose'

modelKeys =
  book:    ['slug', 'book', 'test', 'klass']
  chapter: ['slug', 'number', 'book']
  verse:   ['slug', 'number', 'body']

describe 'goose', ->
  
  before (ready) ->
    config.db.connect()
    ready()

  describe '#getBook', ->
    it 'should return correct fields', (done) ->
      goose.getBook book: 'genesis', (err, book) ->
        should.not.exist(err)
        testGenesis(book)
        done()

  describe '#getBooks', ->
    it 'should return correct fields', (done) ->
      goose.getBooks {}, (err, books) ->
        should.not.exist(err)
        books.should.have.length 66
        book = books[0]
        testGenesis(book)
        done()

  describe '#getChapter', ->
    it 'should return correct fields', (done) ->
      goose.getChapter book: 'genesis', chapter: 1, (err, chapter) ->
        should.not.exist(err)
        testGenesis_1(chapter)
        done()

  describe '#getChapters', ->
    it 'should return correct fields', (done) ->
      goose.getChapters book: 'genesis', (err, chapters) ->
        chapters.should.have.length 50
        chapter = chapters[0]
        testGenesis_1(chapter)
        done()

  describe '#getVerse', ->
    it 'should return correct fields', (done) ->
      goose.getVerse book: 'genesis', chapter: 1, verse: 1, (err, verse) ->
        testGenesis_1_1(verse)
        done()

  describe '#getVerses', ->
    it 'should return correct fields', (done) ->
      goose.getVerses book: 'genesis', chapter: 1, (err, verses) ->
        should.not.exist(err)
        verses.should.have.length 31
        verse = verses[0]
        testGenesis_1_1(verse)
        done()

  after (done) ->
    config.db.disconnect()
    done()


#
# private helpers
#

testGenesis = (book) ->
  book.should.have.keys(modelKeys.book)
  book.should.have.property('slug', 'genesis')
  book.should.have.property('book', 'Genesis')

testGenesis_1 = (chapter) ->
  chapter.should.have.keys(modelKeys.chapter)
  chapter.should.have.property('slug', 'genesis_1')
  chapter.should.have.property('number', 1)

testGenesis_1_1 = (verse) ->
  verse.should.have.keys(modelKeys.verse)
  verse.should.have.property('slug', 'genesis_1_1')
  verse.should.have.property('number', 1)
  verse.should.have.property('body', 'In the beginning God created the heaven and the earth.')
