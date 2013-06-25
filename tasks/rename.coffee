async  = require 'async'
debug  = require 'debug'
_      = require 'underscore'
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
  {book: "titus", slug: "titus", newBook: "Titus"}
  {book: "galatians", slug: "galatians", newBook: "Galatians"}
  {book: "romans", slug: "romans", newBook: "Romans"}
  {book: "obadiah", slug: "obadiah", newBook: "Obadiah"}
  {book: "ecclesiastes", slug: "ecclesiastes", newBook: "Ecclesiastes"}
  {book: "jeremiah ", slug: "jeremiah", newBook: "Jeremiah"}
  {book: "isaiah ", slug: "isaiah", newBook: "Isaiah"}
  {book: "st.mark", slug: "mark", newBook: "Mark"}
  {book: "st. matthew", slug: "matthew", newBook: "Matthew"}
  {book: "daniel", slug: "daniel", newBook: "Daniel"}
  {book: "st. john ", slug: "john", newBook: "John"}
  {book: "psalms  ", slug: "psalms", newBook: "Psalms"}
  {book: "psalms  ", slug: "psalms", newBook: "Psalms"}
  {book: "lamentations", slug: "lamentations", newBook: "Lamentations"}
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
  {book: "first samuel", slug: "1-samuel", newBook: "1 Samuel"}
  {book: "second samuel", slug: "2-samuel", newBook: "2 Samuel"}
  {book: "ezra", slug: "ezra", newBook: "Ezra"}
  {book: "first kings", slug: "1-kings", newBook: "1 Kings"}
  {book: "second kings", slug: "2-kings", newBook: "2 Kings"}
  {book: "1 corinthians", slug: "1-corinthians", newBook: "1 Corinthians"}
  {book: "2 corinthians", slug: "2-corinthians", newBook: "2 Corinthians"}
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
  {book: "hebrews", slug: "hebrews", newBook: "Hebrews"}
  {book: "james", slug: "james", newBook: "James"}
  {book: "first  peter", slug: "1-peter", newBook: "1 Peter"}
  {book: "second peter", slug: "2-peter", newBook: "2 Peter"}
  {book: "first john", slug: "1-john", newBook: "1 John"}
  {book: "second john", slug: "2-john", newBook: "2 John"}
  {book: "third john", slug: "3-john", newBook: "3 John"}
  {book: "jude", slug: "jude", newBook: "Jude"}
  {book: "revelation", slug: "revelation", newBook: "Revelation"}
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
    res[0] = _.reduce(res[0], ((memo, num) -> memo + num), 0)
    res[1] = _.reduce(res[0], ((memo, num) -> memo + num), 0)
    debug("Done", res)
  config.db.disconnect()

