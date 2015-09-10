require 'figlet'
require 'dotenv'
require 'slack-ruby-client'

Dotenv.load

class Application < Sinatra::Base
  get '/' do
    @word = params['word'] || 'hi'
    @positive = params['positive'] || 'black_square'
    @negative = params['negative'] || 'white_square'

    @output = render_text @word, @positive, @negative

    erb :index
  end

  post '/' do
    client = Slack::Web::Client.new(token: ENV['SLACK_API_TOKEN'])

    channel = params[:channel_name]

    puts "CHANNEL: #{channel}"

    args = params[:text].split(" ")

    output = render_text args[0], args[1], args[2]

    options = {
      channel: channel,
      text: output,
      username: "Artsy",
      icon_url: "https://www.artsy.net/images/icon-150.png"
    }

    client.chat_postMessage options
    status 200
    body ''
  end

  def render_text(word, positive, negative)
    figlet = Figlet::Typesetter.new(Figlet::Font.new('banner.flf'))

    ":off:\n" + figlet[word]
      .gsub!(/\S/, (":#{positive}:"))
      .gsub!(' ', (":#{negative}:"))
  end
end