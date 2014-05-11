send = require 'response-send'

response = ()->
  return (req,res,next)->
    res.req = req
    res.send = send

    res.json = send.json
      spaces : 2
    
    res.jsonp = (data, callback = 'callback') ->
      # utf7 xss
      hat_content = "\r\n" 

      data = data.toString()  if Buffer.isBuffer(data)
      body = JSON.stringify(data)
      body = hat_content + callback + "(" + body + ")"
      res.charset = res.charset or "utf-8"
      res.setHeader "Content-Type", "application/javascript"
      res.send body

    res.redirect = (url, status = 302) ->
      # status = parseInt(status, 10)  if typeof status is "string"
      res.statusCode = status
      res.setHeader "Location", url
      res.end()

    next()


module.exports = exports = response

