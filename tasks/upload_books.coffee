async  = require 'async'
debug  = require 'debug'
config = require '../config'
Book   = require '../models/book'

debug = debug('upload-books')

uploadBook = (book, callback) ->
  book = new Book(book)
  book.save(callback)

books = [

  #
  # Old Testament
  #

  # Law
  {book: 'Genesis'     , slug: 'genesis'     , test: 'old' , klass: 'law' }
  {book: 'Exodus'      , slug: 'exodus'      , test: 'old' , klass: 'law' }
  {book: 'Leviticus'   , slug: 'leviticus'   , test: 'old' , klass: 'law' }
  {book: 'Numbers'     , slug: 'numbers'     , test: 'old' , klass: 'law' }
  {book: 'Deuteronomy' , slug: 'deuteronomy' , test: 'old' , klass: 'law' }

  # History
  {book: 'Joshua'       , slug: 'joshua'       , test: 'old' , klass: 'history' }
  {book: 'Judges'       , slug: 'judges'       , test: 'old' , klass: 'history' }
  {book: 'Ruth'         , slug: 'ruth'         , test: 'old' , klass: 'history' }
  {book: '1 Samuel'     , slug: '1-samuel'     , test: 'old' , klass: 'history' }
  {book: '2 Samuel'     , slug: '2-samuel'     , test: 'old' , klass: 'history' }
  {book: '1 Kings'      , slug: '1-kings'      , test: 'old' , klass: 'history' }
  {book: '2 Kings'      , slug: '2-kings'      , test: 'old' , klass: 'history' }
  {book: '1 Chronicles' , slug: '1-chronicles' , test: 'old' , klass: 'history' }
  {book: '2 Chronicles' , slug: '2-chronicles' , test: 'old' , klass: 'history' }
  {book: 'Ezra'         , slug: 'ezra'         , test: 'old' , klass: 'history' }
  {book: 'Nehemiah'     , slug: 'nehemiah'     , test: 'old' , klass: 'history' }
  {book: 'Esther'       , slug: 'esther'       , test: 'old' , klass: 'history' }

  # Poetry and Wisdom
  {book: 'Job'             , slug: 'job'             , test: 'old' , klass: 'poetry_wisdom' }
  {book: 'Psalms'          , slug: 'psalms'          , test: 'old' , klass: 'poetry_wisdom' }
  {book: 'Proverbs'        , slug: 'proverbs'        , test: 'old' , klass: 'poetry_wisdom' }
  {book: 'Ecclesiastes'    , slug: 'ecclesiastes'    , test: 'old' , klass: 'poetry_wisdom' }
  {book: 'Song of Solomon' , slug: 'song-of-solomon' , test: 'old' , klass: 'poetry_wisdom' }

  # Major prophets
  {book: 'Isaiah'       , slug: 'isaiah'       , test: 'old' , klass: 'prophets-major' }
  {book: 'Jeremiah'     , slug: 'jeremiah'     , test: 'old' , klass: 'prophets-major' }
  {book: 'Ezekiel'      , slug: 'ezekiel'      , test: 'old' , klass: 'prophets-major' }
  {book: 'Lamentations' , slug: 'lamentations' , test: 'old' , klass: 'prophets-major' }
  {book: 'Daniel'       , slug: 'daniel'       , test: 'old' , klass: 'prophets-major' }

  # Minor Prophets
  {book: 'Hosea'     , slug: 'hosea'     , test: 'old' , klass: 'prophets-minor' }
  {book: 'Joel'      , slug: 'joel'      , test: 'old' , klass: 'prophets-minor' }
  {book: 'Amos'      , slug: 'amos'      , test: 'old' , klass: 'prophets-minor' }
  {book: 'Obadiah'   , slug: 'obadiah'   , test: 'old' , klass: 'prophets-minor' }
  {book: 'Jonah'     , slug: 'jonah'     , test: 'old' , klass: 'prophets-minor' }
  {book: 'Micah'     , slug: 'micah'     , test: 'old' , klass: 'prophets-minor' }
  {book: 'Nahum'     , slug: 'nahum'     , test: 'old' , klass: 'prophets-minor' }
  {book: 'Habakkuk'  , slug: 'habakkuk'  , test: 'old' , klass: 'prophets-minor' }
  {book: 'Zephaniah' , slug: 'zephaniah' , test: 'old' , klass: 'prophets-minor' }
  {book: 'Haggai'    , slug: 'haggai'    , test: 'old' , klass: 'prophets-minor' }
  {book: 'Zechariah' , slug: 'zechariah' , test: 'old' , klass: 'prophets-minor' }
  {book: 'Malachi'   , slug: 'malachi'   , test: 'old' , klass: 'prophets-minor' }

  #
  # New Testament
  #

  # Gospels
  {book: 'Matthew' , slug: 'matthew' , test: 'new' , klass: 'gospel-synoptic' }
  {book: 'Mark'    , slug: 'mark'    , test: 'new' , klass: 'gospel-synoptic' }
  {book: 'Luke'    , slug: 'luke'    , test: 'new' , klass: 'gospel-synoptic' }
  {book: 'John'    , slug: 'john'    , test: 'new' , klass: 'gospel'          }
  {book: 'Acts'    , slug: 'acts'    , test: 'new' , klass: 'gospel'          }

  # Pauline Epistles
  {book: 'Romans'          , slug: 'romans'          , test: 'new' , klass: 'epistles-pauline' }
  {book: '1 Corinthians'   , slug: '1-corinthians'   , test: 'new' , klass: 'epistles-pauline' }
  {book: '2 Corinthians'   , slug: '2-corinthians'   , test: 'new' , klass: 'epistles-pauline' }
  {book: 'Galatians'       , slug: 'galatians'       , test: 'new' , klass: 'epistles-pauline' }
  {book: 'Ephesians'       , slug: 'ephesians'       , test: 'new' , klass: 'epistles-pauline' }
  {book: 'Philippians'     , slug: 'philippians'     , test: 'new' , klass: 'epistles-pauline' }
  {book: 'Colossians'      , slug: 'colossians'      , test: 'new' , klass: 'epistles-pauline' }
  {book: '1 Thessalonians' , slug: '1-thessalonians' , test: 'new' , klass: 'epistles-pauline' }
  {book: '2 Thessalonians' , slug: '2-thessalonians' , test: 'new' , klass: 'epistles-pauline' }

  # Pastoral Epistles
  {book: '1 Timothy' , slug: '1-timothy' , test: 'new' , klass: 'epistles-pastoral' }
  {book: '2 Timothy' , slug: '2-timothy' , test: 'new' , klass: 'epistles-pastoral' }
  {book: 'Titus'     , slug: 'titus'     , test: 'new' , klass: 'epistles-pastoral' }
  {book: 'Philemon'  , slug: 'philemon'  , test: 'new' , klass: 'epistles-pastoral' }
  {book: 'Hebrews'   , slug: 'hebrews'   , test: 'new' , klass: 'epistles-pastoral' }

  # General Epistles
  {book: 'James'   , slug: 'james'   , test: 'new' , klass: 'epistles-general' }
  {book: '1 Peter' , slug: '1-peter' , test: 'new' , klass: 'epistles-general' }
  {book: '2 Peter' , slug: '2-peter' , test: 'new' , klass: 'epistles-general' }
  {book: '1 John'  , slug: '1-john'  , test: 'new' , klass: 'epistles-general' }
  {book: '2 John'  , slug: '2-john'  , test: 'new' , klass: 'epistles-general' }
  {book: '3 John'  , slug: '3-john'  , test: 'new' , klass: 'epistles-general' }
  {book: 'Jude'    , slug: 'jude'    , test: 'new' , klass: 'epistles-general' }

  # Revelation
  {book: 'Revelation', slug: 'revelation', test: 'new', klass: 'revelation' }
]

config.db.connect()
async.series [
  (callback) ->
    Book.remove({}, callback)
  (callback) ->
    async.map(books, uploadBook, callback)
], (err, res) ->
  if err
    debug 'error', err
  else
    debug 'Done', res
  config.db.disconnect()
