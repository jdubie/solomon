########################################
## DB
db = {}
mongoose = require 'mongoose'

db.connect = () ->
  mongoose.connect('mongodb://localhost/bible')

db.disconnect = () ->
  mongoose.disconnect()
########################################

########################################
## SOLR
solr = {}
solrClient = require 'solr-client'

solr.connect = () ->
  client = solrClient.createClient
    host: '192.168.144.1'
  client.autoCommit = true
  client

exports.solr = solr
########################################

########################################
## Constants
exports.TEXT_ROOT = 'data'
exports.BOOK_IDS = [ 'genesis' ]
########################################

exports.db = db
