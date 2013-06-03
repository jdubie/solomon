async  = require 'async'
config = require 'config'
debug  = require 'debug'
Book   = require 'models/book'

debug = debug('upload-books')

uploadBook = (book, callback) ->
  book = new Book(book)
  book.save(callback)

books = [
  {slug: "jeremiah", book: "Jeremiah"}
  {slug: "isaiah", book: "Isaiah"}
  {slug: "mark", book: "Mark"}
  {slug: "daniel", book: "Daniel"}
  {slug: "john", book: "John"}
  {slug: "psalms", book: "Psalms"}
  {slug: "psalms", book: "Psalms"}
  {slug: "jeremiah", book: "Jeremiah"}
  {slug: "ezekiel", book: "Ezekiel"}
  {slug: "hosea", book: "Hosea"}
  {slug: "luke", book: "Luke"}
  {slug: "1-thessalonians", book: "1 Thessalonians"}
  {slug: "ephesians", book: "Ephesians"}
  {slug: "genesis", book: "Genesis"}
  {slug: "amos", book: "Amos"}
  {slug: "colossians", book: "Colossians"}
  {slug: "malachi", book: "Malachi"}
  {slug: "zechariah", book: "Zechariah"}
  {slug: "acts", book: "Acts"}
  {slug: "philippians", book: "Philippians"}
  {slug: "1-timothy", book: "1 Timothy"}
  {slug: "2-timothy", book: "2 Timothy"}
  {slug: "numbers", book: "Numbers"}
  {slug: "2-samuel", book: "2 Samuel"}
  {slug: "1-samuel", book: "1 Samuel"}
  {slug: "ezra", book: "Ezra"}
  {slug: "2-kings", book: "2 Kings"}
  {slug: "1-chronicles", book: "1 Chronicles"}
  {slug: "nehemiah", book: "Nehemiah"}
  {slug: "esther", book: "Esther"}
  {slug: "2-chronicles", book: "2 Chronicles"}
  {slug: "job", book: "Job"}
  {slug: "song-of-solomon", book: "Song of Solomon"}
  {slug: "proverbs", book: "Proverbs"}
  {slug: "exodus", book: "Exodus"}
  {slug: "leviticus", book: "Leviticus"}
  {slug: "deuteronomy", book: "Deuteronomy"}
  {slug: "joshua", book: "Joshua"}
  {slug: "ruth", book: "Ruth"}
  {slug: "judges", book: "Judges"}
  {slug: "joel", book: "Joel"}
  {slug: "jonah", book: "Jonah"}
  {slug: "micah", book: "Micah"}
  {slug: "nahum", book: "Nahum"}
  {slug: "habakkuk", book: "Habakkuk"}
  {slug: "zephaniah", book: "Zephaniah"}
  {slug: "haggai", book: "Haggai"}
  {slug: "2-thessalonians", book: "2 Thessalonians"}
  {slug: "philemon", book: "Philemon"}
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
