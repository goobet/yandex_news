require 'net/http'

class YandexApi
  NEWS_URL = 'https://news.yandex.ru'.freeze

  def topic
    response = Net::HTTP.get(URI(NEWS_URL))
    html = Nokogiri::HTML(response)

    date = html.css('.story__aside .story__info .story__date')
               .text.split("\n").last
    date = Time.zone.parse(date)
    { title: html.css('.story__aside .story__topic .story__title').text,
      text: html.css('.story__aside .story__topic .story__text').text,
      date: date }
  end
end
