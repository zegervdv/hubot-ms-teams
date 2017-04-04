try
  {Robot,Adapter,TextMessage,User} = require 'hubot'
catch
  prequire = require('parent-require')
  {Robot,Adapter,TextMessage,User} = prequire 'hubot'


class MSTeams extends Adapter

  constructor: ->
    super
   
  send: (envelope, strings...) ->
    @robot.logger.info "Calling send"
    for str in strings
      data = JSON.stringify({
        text: str
      })
      @robot.http(@send_url)
        .header('Content-Type', 'application/json')
        .post(data) (err, res, body) =>
          if err
            @robot.logger.error err
          @robot.logger.info body
  
  reply: (envelope, strings...) ->
    @robot.logger.info "Calling reply"

  run: ->
    @robot.logger.info "Started"
    @emit "connected"
    @send_url = process.env.MS_TEAMS_SEND_URL
    @send "all", "This is your robot calling"

  exports.use = (robot) ->
    new MSTeams robot 
