async = require 'async'
config = require './config'

Book    = require './models/book'
Chapter = require './models/chapter'
Verse   = require './models/verse'

models = [Book, Chapter, Verse]

removeModel = (model, callback) ->
  model.remove({}, callback)

#######################################
config.db.connect()
async.map models, removeModel, (err, res) ->
  config.db.disconnect()
  console.log 'done'
#######################################
