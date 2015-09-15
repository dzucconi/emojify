require 'spec_helper'

describe Application do
  include Rack::Test::Methods

  def app
    subject
  end

  context 'GET' do
    it 'returns the default' do
      get '/'
      expect(last_response.status).to eq 200
      body = last_response.body
      expect(body).to start_with "<form action='/' method='GET'>"
      expect(body).to include ":white_square::black_square::white_square:"
      expect(body).to end_with "</textarea>"
    end
    it 'uses params' do
      get '/', word: 'test', positive: 'x', negative: 'y'
      expect(last_response.status).to eq 200
      body = last_response.body
      expect(body).to include "::y::x::y::y::y:"
    end
  end

  context 'POST' do
    context 'without SLACK_API_TOKEN' do
      it 'returns an emoji response' do
        post '/', { text: 'x y z' }
        expect(last_response.status).to eq 200
        body = JSON.parse(last_response.body)
        expect(body['text']).to include "\n:z::z::z::y::y::z::z::z:\n"
      end
    end
    context 'with SLACK_API_TOKEN' do
      let(:client) { double(Slack::Web::Client) }
      before do
        ENV['SLACK_API_TOKEN'] = 'token'
        allow(Slack::Web::Client).to receive(:new).and_return(client)
      end
      after do
        ENV.delete('SLACK_API_TOKEN')
      end
      it 'publicly posts an emoji response' do
        expect(client).to receive(:chat_postMessage).with(
          channel: '123',
          text: ":z::z::z::z::z::z::z::z:\n:z::y::z::z::z::z::y::z:\n:z::z::y::z::z::y::z::z:\n:z::z::z::y::y::z::z::z:\n:z::z::z::y::y::z::z::z:\n:z::z::y::z::z::y::z::z:\n:z::y::z::z::z::z::y::z:\n:z::z::z::z::z::z::z::z:",
          username: nil,
          icon_url: nil
        )
        post '/', { text: 'x y z', channel_id: '123' }
        expect(last_response.status).to eq 200
        expect(last_response.body).to eq ''
      end
    end
  end
end
