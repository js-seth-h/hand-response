request = require 'supertest'


describe 'hand-response', ()->

  ho = require 'handover'
  response = require('../response')
  http = require 'http'
  check = null
  server = http.createServer ho.make [
    response(),
    (req,res, next)->
      return next() unless  req.url is '/jsonp'
      res.jsonp check
    (req,res, next)->
      return next() unless  req.url is '/redirect'
      res.redirect '/'
    (req,res, next)->
      # console.log check
      res.send(check)
  ]


  it 'send text', (done)-> 
    check = "hello"
    request(server)
      .get('/')
      .expect(200, check)
      .expect('Content-Type', 'text/html', done)


  it 'send json', (done)-> 
    check = 
      status : 'ok'
    request(server)
      .get('/')
      .expect(200)
      .end (err, res)->
        return done(err) if (err) 
        return done(err) if not  JSON.stringify(res.body) is JSON.stringify check
        done() 


  it 'redirect', (done)-> 
    request(server)
      .get('/redirect')
      .expect(302)
      .end done


  it "send jsonp ", (done) ->
    check = 
      status: 'ok'
    request(server)
      .get("/jsonp")
      .expect(200)
      .expect("Content-Type", "application/javascript")
      .expect '\r\ncallback({"status":"ok"})', done




  describe 'with-connect', ()->


    connect = require('connect') 

    app = connect()
    app.use response()
    app.use (req,res, next)->
      res.send( "test")


    it 'send text', (done)-> 
      check = "hello"
      request(server)
        .get('/')
        .expect(200, check)
        .end(done)
