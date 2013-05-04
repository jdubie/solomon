express = require 'express'
debug   = require 'debug'
path    = require 'path'
config  = require 'config'

#Verse   = require 'models/verse'
mongoose = require 'mongoose'
schema = new mongoose.Schema({ book: 'string', verse: 'number', body: 'string' })
Verse = mongoose.model('Verse', schema)

debug = debug('server')

app = express()
app.use express.static path.join(__dirname, 'public')

config.db.connect()

app.get '/:book/:chapter/:verse', (req, res) ->
  {book, chapter, verse} = req.params
  chapter = parseInt(chapter)
  verse = parseInt(verse)
  Verse.findOne {book, chapter, verse}, (err, verse) ->
    res.json({verse})


#solr    = require 'solr-client'
#client = config.solr.connect()
#app.get '/verses', (req, res) ->
#  {q} = req.query
#  q ?= '*'
#
#  solrQuery = client.createQuery()
#    .q(q)
#    .start(0)
#    .rows(10)
#    .sort('score desc')
#    .fl(encodeURIComponent('* score'))
#
#  client.search solrQuery, (err, solrRes) ->
#    if err
#      console.log(err)
#    else
#      res.json(verses: solrRes.response.docs)

app.listen(8002)
