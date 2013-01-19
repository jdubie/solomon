config = require 'config'
debug  = require 'debug'

debug = debug('solr-wipe')

query = '*:*'

########################################
client = config.solr.connect()
client.deleteByQuery query, (err) ->
  throw new Error(err) if err
  config.db.disconnect()
  debug 'done'
########################################
