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
exports.BOOK_IDS = [
  'genesis'
  'exodus'
  'levit'
  'numbers'
  'deut'
  'joshua'
  'judges'
  'ruth'
  '1samuel'
  '2samuel'
  '1kings'
  '2kings'
  '1chron'
  '2chron'
  'ezra'
  'nehemiah'
  'esther'
  'job'
  'psalms'
  'proverbs'
  'eccl'
  'song'
  'isaiah'
  'jeremiah'
  'lament'
  'ezekiel'
  'daniel'
  'hosea'
  'joel'
  'amos'
  'obadiah'
  'jonah'
  'micah'
  'nahum'
  'habakkuk'
  'zeph'
  'haggai'
  'zech'
  'malachi'
  'matthew'
  'mark'
  'luke'
  'john'
  'acts'
  'romans'
  '1corinth'
  '2corinth'
  'galatian'
  'ephesian'
  'philipp'
  'colossia'
  '1thess'
  '2thess'
  '1timothy'
  '2timothy'
  'titus'
  'philemon'
  'hebrews'
  'james'
  '1peter'
  '2peter'
  '1john'
  '2john'
  '3john'
  'jude'
  'rev'
]
########################################

exports.db = db
