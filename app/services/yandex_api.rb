require 'net/http'

class YandexApi
  NEWS_URL = 'https://news.yandex.ru'.freeze
  SELECTORS = {
    title: '.story__aside .story__info .story__date',
    text: '.story__aside .story__topic .story__text',
    date: '.story__aside .story__info .story__date'
  }.freeze

  def topic
    response = Net::HTTP.get(URI(NEWS_URL))
    html = Nokogiri::HTML(response)

    { title: html.css(SELECTORS[:title]).text,
      text: html.css(SELECTORS[:text]).text,
      date: parse_date(html) }
  end

  private

  def parse_date(html)
    date = html.css(SELECTORS[:date]).text.split("\n").last
    Time.zone.parse(date)
  end
end
