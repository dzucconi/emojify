# emojify

## Slack command
```
/emojify [text] [foreground] [background]
```

## Wat?

![](screenshots/shark.gif)

## Setup

#### Deploy to Heroku

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

#### Incoming Webook

You need an API token to post emoji art back to Slack. Setup an [incoming webhook](https://slack.com/services/new/incoming-webhook) and note the API token.

#### Slash Command

You need to respond to the `/emojify` command. Setup a new [slash command](https://slack.com/services/new/slash-commands) with the following settings.

* Command: `/emojify`
* URL: `https://<your heroku app>.herokuapp.com/`
* Method: `POST`
* Check _Show this command in the autocomplete list_.
* Description: `Emojify your text`.
* Usage hint: `[text] [foreground] [background]`

#### Configure

Configure the Heroku application with `heroku config add`.

* SLACK_API_TOKEN: The token from the incoming webhook.
* USERNAME: Optional name of bot.
* ICON: Optional URL to an image to use as the icon for messages.

