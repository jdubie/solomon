config = require 'config'
debug  = require 'debug'
async  = require 'async'
Verses = require 'models/verse'

debug = debug('solr-load')

getVerses = (callback) ->
  Verses
    .find()
    .exec (err, verses) ->
      return callback(err) if err
      verses = verses.map (verse) -> verse.toSolr()
      callback(null, verses)

########################################
config.db.connect()
async.waterfall [
  (next) ->
    getVerses(next)
  (verses, next) ->
    client = config.solr.connect()
    client.add(verses, next)
], (err) ->
  throw new Error(err) if err
  config.db.disconnect()
  debug 'done'
########################################
