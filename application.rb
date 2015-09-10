require 'figlet'

class Application < Sinatra::Base
  get '/' do
    @word = params['word'] || 'hi'
    @positive = params['positive'] || 'black_square'
    @negative = params['negative'] || 'white_square'

    figlet = Figlet::Typesetter.new(Figlet::Font.new('banner.flf'))

    @output = figlet[@word]
      .gsub!(/\S/, (":#{@positive}:"))
      .gsub!(' ', (":#{@negative}:"))

    erb :index
  end
end