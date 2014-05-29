# httpware-response


> monkey patch of response


## Features

* compatible with [connect/express][ce], [flyway][flyway]
[ce]: https://github.com/senchalabs/connect
[flyway]: https://www.npmjs.org/package/flyway

## Support Functions.

```coffee

  flyway = require 'flyway'
  server = http.createServer flyway [
    require('httpware-response')(),
    (req,res, next)->
      res.redirect '/'
      res.send( "test")
      res.send( { val : 1} )
      res.json( {val : 1} )
      res.jsonp( {val : 1} )
  ]

``` 

```coffee

connect = require('connect')
http = require('http')

app = connect()
app.use require('httpware-response')()
app.use (req,res, next)->
      res.redirect '/'
      res.send( "test")
      res.send( { val : 1} )
      res.json( {val : 1} )
      res.jsonp( {val : 1} )



app.listen(PORT)

``` 
 
 
## License

(The MIT License)

Copyright (c) 2014 junsik &lt;js@seth.h@google.com&gt;

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 