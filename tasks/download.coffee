path    = require 'path'
fs      = require 'fs'
url     = require 'url'
async   = require 'async'
debug   = require 'debug'
request = require 'request'
_       = require 'underscore'
config  = require 'config'

SOURCE =
  pathname: '/sbs777/bible/text'
  protocol: 'http:'
  host:  'atschool.eduweb.co.uk'

debug = debug('download')

getUrl = (bookId) ->
  bookPath = path.join(SOURCE.pathname, "#{bookId}.txt")
  url.format(_.extend({}, SOURCE, pathname: bookPath))

fetchBook = (bookId, callback) ->
  debug 'fetching', getUrl(bookId)
  bookOutlet = fs.createWriteStream(path.join(config.TEXT_ROOT, "#{bookId}.txt"))
  request.get(getUrl(bookId)).pipe(bookOutlet)
  bookOutlet.on('close', callback)

########################################
async.map config.BOOK_IDS, fetchBook, (err, res) ->
  if err
    throw new Error(err)
  else
  debug 'done'
########################################
