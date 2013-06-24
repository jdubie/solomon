fs     = require 'fs'
path   = require 'path'
debug  = require 'debug'
async  = require 'async'
_      = require 'underscore'
config = require 'config'
Verse  = require 'models/verse'

debug = debug('upload')

readBook = (bookId, callback) ->
  fs.readFile(path.join(config.TEXT_ROOT, "#{bookId}.txt"), 'utf8', callback)

parseBook = (bookContent) ->
  bookContent = bookContent.split('\r').join('')
  bookContent = bookContent.split('\n')

  titleExp = /^(?:[1-9A-Z\.]+ *)+[ ]*$/
  #console.log bookContent[0..4]
  book = _(bookContent).find (line) ->
    line.match(titleExp)
  book = book.toLowerCase()

  verseExp = /^ ?([0-9]+):([0-9]+): (.+)$/
  verses = _(bookContent).filter (line) ->
    line.match(verseExp)
  _(verses).map (line) ->
    [__, chapter, verse, body] = line.match(verseExp)
    {book, verse, chapter, body}

uploadVerse = (verse, callback) ->
  v = new Verse(verse)
  v.save(callback)

uploadBook = (bookId, callback) ->
  debug 'bookId', bookId
  readBook bookId, (err, bookBuffer) ->
    callback(err) if err
    verses = parseBook(bookBuffer)
    debug 'verses', verses.length
    async.map(verses, uploadVerse, callback)

########################################
config.db.connect()
async.map config.BOOK_IDS, uploadBook, (err, res) ->
  throw new Error(err) if err
  debug 'done'
  config.db.disconnect()
########################################
