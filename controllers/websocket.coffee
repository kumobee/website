util = require 'util'
app = require '../config/app'

app.ws?.sockets.on 'connection', (client) ->
  client.on 'message', (data) ->
    return if Date.now() - client.lastMessageAt < 200
    client.lastMessageAt = Date.now()
    data.id = client.id
    client.json.broadcast.send data
  client.on 'disconnect', ->
    client.json.broadcast.send id: client.id, disconnect: true
