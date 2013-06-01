express = require 'express'
debug   = require 'debug'
path    = require 'path'
config  = require './config'
goose   = require './goose'

debug = debug('server')

app = express()
app.use express.static('public')
app.use (req, res, next) ->
  debug "#{req.method} #{req.path}", req.query
  next()

config.db.connect()

app.get '/books/:slug', (req, res) ->
  book = req.params.slug
  goose.getBook {book}, (err, book) ->
    res.json(book)

app.get '/books', (req, res) ->
  goose.getBooks {}, (err, books) ->
    res.json(books)

app.get '/chapters/:slug', (req, res) ->
  [book, chapter] = req.params.slug.split('_')
  goose.getChapter {book, chapter}, (err, chapter) ->
    res.json(chapter)

app.get '/chapters', (req, res) ->
  {book} = req.query
  goose.getChapters {book}, (err, chapters) ->
    res.json(chapters)

app.get '/verses', (req, res) ->
  {book, chapter} = req.query
  goose.getVerses {book, chapter}, (err, versus) ->
    res.json(versus)

app.get '/*', (req, res) ->
  debug 'req.path', req.path
  debug 'req.query', req.query
  res.send(404)

app.listen(8002)
