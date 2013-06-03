async  = require 'async'
debug  = require 'debug'
config = require 'config'
Verse  = require 'models/verse'

debug = debug('rename')

updateSlug = ({book, slug}, callback) ->
  debug "\"#{book}\"", "\"#{slug}\""
  Verse.update({book}, { $set: {slug} }, multi: true, callback)

updateName = ({book, newBook}, callback) ->
  debug "\"#{book}\"", "\"#{newBook}\""
  return callback(null, 0) if book == newBook
  Verse.update({book}, { $set: { book: newBook }}, multi: true, callback)

books = [
  {book: "jeremiah ", slug: "jeremiah", newBook: "Jeremiah"}
  {book: "isaiah ", slug: "isaiah", newBook: "Isaiah"}
  {book: "st.mark", slug: "mark", newBook: "Mark"}
  {book: "daniel", slug: "daniel", newBook: "Daniel"}
  {book: "st. john ", slug: "john", newBook: "John"}
  {book: "psalms  ", slug: "psalms", newBook: "Psalms"}
  {book: "psalms  ", slug: "psalms", newBook: "Psalms"}
  {book: "the lamentations of jeremiah", slug: "jeremiah", newBook: "Jeremiah"}
  {book: "ezekiel ", slug: "ezekiel", newBook: "Ezekiel"}
  {book: "hosea", slug: "hosea", newBook: "Hosea"}
  {book: "st.  luke", slug: "luke", newBook: "Luke"}
  {book: "first thessalonians", slug: "1-thessalonians", newBook: "1 Thessalonians"}
  {book: "ephesians", slug: "ephesians", newBook: "Ephesians"}
  {book: "genesis", slug: "genesis", newBook: "Genesis"}
  {book: "amos", slug: "amos", newBook: "Amos"}
  {book: "colossians", slug: "colossians", newBook: "Colossians"}
  {book: "malachi", slug: "malachi", newBook: "Malachi"}
  {book: "zechariah", slug: "zechariah", newBook: "Zechariah"}
  {book: "acts of the apostles ", slug: "acts", newBook: "Acts"}
  {book: "philippians", slug: "philippians", newBook: "Philippians"}
  {book: "first timothy", slug: "1-timothy", newBook: "1 Timothy"}
  {book: "second timothy", slug: "2-timothy", newBook: "2 Timothy"}
  {book: "numbers", slug: "numbers", newBook: "Numbers"}
  {book: "second samuel", slug: "2-samuel", newBook: "2 Samuel"}
  {book: "first samuel", slug: "1-samuel", newBook: "1 Samuel"}
  {book: "ezra", slug: "ezra", newBook: "Ezra"}
  {book: "second kings", slug: "2-kings", newBook: "2 Kings"}
  {book: "first chronicles", slug: "1-chronicles", newBook: "1 Chronicles"}
  {book: "nehemiah", slug: "nehemiah", newBook: "Nehemiah"}
  {book: "esther", slug: "esther", newBook: "Esther"}
  {book: "second chronicles", slug: "2-chronicles", newBook: "2 Chronicles"}
  {book: "job", slug: "job", newBook: "Job"}
  {book: "the song of solomon", slug: "song-of-solomon", newBook: "Song of Solomon"}
  {book: "proverbs", slug: "proverbs", newBook: "Proverbs"}
  {book: "exodus", slug: "exodus", newBook: "Exodus"}
  {book: "leviticus", slug: "leviticus", newBook: "Leviticus"}
  {book: "deuteronomy  ", slug: "deuteronomy", newBook: "Deuteronomy"}
  {book: "joshua", slug: "joshua", newBook: "Joshua"}
  {book: "ruth", slug: "ruth", newBook: "Ruth"}
  {book: "judges", slug: "judges", newBook: "Judges"}
  {book: "joel", slug: "joel", newBook: "Joel"}
  {book: "jonah", slug: "jonah", newBook: "Jonah"}
  {book: "micah", slug: "micah", newBook: "Micah"}
  {book: "nahum", slug: "nahum", newBook: "Nahum"}
  {book: "habakkuk", slug: "habakkuk", newBook: "Habakkuk"}
  {book: "zephaniah", slug: "zephaniah", newBook: "Zephaniah"}
  {book: "haggai", slug: "haggai", newBook: "Haggai"}
  {book: "second thessalonians", slug: "2-thessalonians", newBook: "2 Thessalonians"}
  {book: "philemon", slug: "philemon", newBook: "Philemon"}
]

config.db.connect()
async.series [
  (callback) ->
    async.map(books, updateSlug, callback)
  (callback) ->
    async.map(books, updateName, callback)
], (err, res) ->
  if err
    debug("error", err)
  else
    debug("Done", res)
  config.db.disconnect()

