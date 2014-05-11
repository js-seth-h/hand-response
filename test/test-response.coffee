request = require 'supertest'


describe 'hand-response', ()->

  ho = require 'handover'
  http = require 'http'
  check = null
  server = http.createServer ho.make [
    require('../response')(),
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

