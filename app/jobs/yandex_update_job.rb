class YandexUpdateJob < ApplicationJob
  def perform
    NewsUpdater.new(topic_provider: YandexApi.new,
                    topic_name: :yandex_topic).process
  end
end
