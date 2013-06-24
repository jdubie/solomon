Book = require 'models/book'
debug = require 'debug'
config = require 'config'
async = require 'async'

debug = debug('order books')

setIndex = ({book, index}, callback) ->
  Book.findOne {book}, (err, bookModel) ->
    #debug '(book, index)', book, index
    if bookModel
      #debug 'book found', bookModel
      if bookModel.index == index
        debug 'nothing to do'
        callback()
      else
        debug 'setting', bookModel.book, index
        bookModel.index = index
        bookModel.save(callback)
    else
      debug 'not found', book
      callback()

books = [
  "Genesis"
  "Exodus"
  "Leviticus"
  "Numbers"
  "Deuteronomy"
  "Joshua"
  "Judges"
  "Ruth"
  "1 Samuel"
  "2 Samuel"
  "1 Kings"
  "2 Kings"
  "1 Chronicles"
  "2 Chronicles"
  "Ezra"
  "Nehemiah"
  "Esther"
  "Job"
  "Psalms"
  "Proverbs"
  "Ecclesiastes"
  "Song of Solomon"
  "Isaiah"
  "Jeremiah"
  "Lamentations"
  "Ezekiel"
  "Daniel"
  "Hosea"
  "Joel"
  "Amos"
  "Obadiah"
  "Jonah"
  "Micah"
  "Nahum"
  "Habakkuk"
  "Zephaniah"
  "Haggai"
  "Zechariah"
  "Malachi"
  "Matthew"
  "Mark"
  "Luke"
  "John"
  "Acts"
  "Romans"
  "1 Corinthians"
  "2 Corinthians"
  "Galatians"
  "Ephesians"
  "Philippians"
  "Colossians"
  "1 Thessalonians"
  "2 Thessalonians"
  "1 Timothy"
  "2 Timothy"
  "Titus"
  "Philemon"
  "Hebrews"
  "James"
  "1 Peter"
  "2 Peter"
  "1 John"
  "2 John"
  "3 John"
  "Jude"
  "Revelation"
]

_books = []
for book, index in books
  _books.push({book, index})

config.db.connect()

async.map _books, setIndex, (err) ->
  if err
    debug "Error", err
  else
    debug "Success"

  config.db.disconnect()

