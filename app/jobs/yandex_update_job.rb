class YandexUpdateJob < ApplicationJob
  def perform
    NewsUpdater.for_yandex.process
  end
end
