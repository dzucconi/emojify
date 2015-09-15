require 'figlet'
require 'dotenv'
require 'slack-ruby-client'
require 'json'

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
    channel = params[:channel_id]
    args = params[:text].split(' ')
    args[1].gsub!(':', '')
    args[2].gsub!(':', '')

    output = render_text args[0], args[1], args[2]

    if (token = ENV['SLACK_API_TOKEN'])
      client = Slack::Web::Client.new(token: token)
      client.chat_postMessage(
        channel: channel,
        text: output,
        username: ENV['USERNAME'],
        icon_url: ENV['ICON']
      )
      body ''
    else
      content_type :json
      body({ text: output, username: ENV['USERNAME'] }.to_json)
    end

    status 200
  end

  def render_text(word, positive, negative)
    figlet = Figlet::Typesetter.new(Figlet::Font.new('banner.flf'))

    figlet[word]
      .gsub!(/\S/, (":#{positive}:"))
      .gsub!(' ', (":#{negative}:"))
  end

  error do
    status 500
    e = env['sinatra.error']
    logger.error e
    "#{e}\n#{e.backtrace.join("\n")}"
  end
end
