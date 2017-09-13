class YandexUpdateJob < ApplicationJob
  def perform
    NewsUpdater.new(api: YandexApi.new, topic_name: :yandex_topic).process
  end
end
