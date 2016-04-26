# Description:
#   Prints the current Heroes of the Storm rotation into the chat
# Commands:
#   hubot free hots rotation - Prints the current Heroes of the Storm rotation into the chat

cheerio = require "cheerio"

module.exports = (robot) ->
    robot.respond /(free )?hots rota(tion)?( please)?/i, (res) ->
        robot.http("http://heroesofthestorm.github.io/free-hero-rotation").get() (err, response, body) ->
            if not err? and response.statusCode is 200
                $ = cheerio.load body

                heroes = $ ".week0 .dropdown-button"

                heroNames = []

                for hero in heroes
                    heroNames.push $(hero).text().trim()

                res.send("**Current Heroes of the Storm Rotation**\n* " + heroNames.join("\n* "));
