# send = require 'response-send'

debug = require('debug')('httpware-response')
response = ()->
  return (req,res,next)->
    res.req = req
    # res.send = send

    # res.json = send.json
    #   spaces : 2
    
    res.json = (data)-> 
      body = JSON.stringify data, null, 2
      res.charset = res.charset || 'utf-8';
      res.setHeader 'Content-Type', 'application/json;charset=' + res.charset
      # this.send
      res.end body 

    res.jsonp = (data, jsonp_callback_name = 'callback') ->
      debug 'send jsonp', data
      # utf7 xss
      hat_content = "\r\n" 

      data = data.toString()  if Buffer.isBuffer(data)
      body = JSON.stringify(data)
      body = hat_content + jsonp_callback_name + "(" + body + ")"
      res.charset = res.charset or "utf-8"
      res.setHeader "Content-Type", "application/javascript"
      # res.send body
      res.end body

    res.redirect = (url, status = 302) ->
      debug 'send redirect', status, url 

      # status = parseInt(status, 10)  if typeof status is "string"
      res.statusCode = status
      res.setHeader "Location", url
      res.end()

    next()


module.exports = exports = response

