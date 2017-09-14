require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before(:each) do
    ya_file_path = File.expand_path('../fixtures/yandex_news.html', __FILE__)
    stub_request(:get, YandexApi::NEWS_URL)
      .to_return(body: File.new(ya_file_path), status: 200)
  end
end
