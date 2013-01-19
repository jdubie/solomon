path    = require 'path'
fs      = require 'fs'
url     = require 'url'
async   = require 'async'
debug   = require 'debug'
request = require 'request'
_       = require 'underscore'

SOURCE =
  pathname: '/sbs777/bible/text'
  protocol: 'http:'
  host:  'atschool.eduweb.co.uk'
DEST = 'data'

debug = debug('download')

getUrl = (bookId) ->
  bookPath = path.join(SOURCE.pathname, "#{bookId}.txt")
  url.format(_.extend({}, SOURCE, pathname: bookPath))

fetchBook = (bookId, callback) ->
  debug 'fetching', getUrl(bookId)
  bookOutlet = fs.createWriteStream(path.join(DEST, "#{bookId}.txt"))
  request.get(getUrl(bookId)).pipe(bookOutlet)
  bookOutlet.on('close', callback)

########################################
bookIds = [ 'genesis' ]
async.map bookIds, fetchBook, (err, res) ->
  throw new Error(err) if err
  debug 'done'
########################################
