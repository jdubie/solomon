express = require 'express'
debug   = require 'debug'
path    = require 'path'
solr    = require 'solr-client'
config  = require 'config'

debug = debug('server')

app = express()
app.use express.static path.join(__dirname, 'public')

client = config.solr.connect()

app.get '/verses', (req, res) ->
  {q} = req.query
  q ?= '*'

  solrQuery = client.createQuery()
    .q(q)
    .start(0)
    .rows(10)
    .sort('score desc')
    .fl(encodeURIComponent('* score'))

  client.search solrQuery, (err, solrRes) ->
    if err
      console.log(err)
    else
      res.json(verses: solrRes.response.docs)

app.listen(8002)
