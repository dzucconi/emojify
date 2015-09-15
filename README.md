# emojify

[![Build Status](https://secure.travis-ci.org/dzucconi/emojify.png)](http://travis-ci.org/dzucconi/emojify)

## Slack command
```
/emojify [text] [foreground] [background]
```

## Wat?

![](screenshots/shark.gif)

## Setup

#### Deploy to Heroku

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

#### Slash Command

You need to respond to the `/emojify` command. Setup a new [slash command](https://slack.com/services/new/slash-commands) with the following settings.

* Command: `/emojify`
* URL: `https://<your heroku app>.herokuapp.com/`
* Method: `POST`
* Check _Show this command in the autocomplete list_.
* Description: `Emojify your text`.
* Usage hint: `[text] [foreground] [background]`

#### Public Emoji Art

By default the emoji output is only visible to you. If you wish to post the emoji publicly, you need an API token. Setup a [bot](https://slack.com/services/new/bot) and note the API token.

Configure the Heroku application with `heroku config add`.

* SLACK_API_TOKEN: The token from the bot if you want to respond publicly.
* USERNAME: Optional name of bot for public messages.
* ICON: Optional URL to an image to use as the icon for public messages.

