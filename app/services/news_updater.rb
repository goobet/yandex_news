class NewsUpdater
  attr_accessor :storage, :api, :topic_name

  def initialize(storage: NewsStorage.new, api:, topic_name:)
    @storage = storage
    @api = api
    @topic_name = topic_name
  end

  def self.for_yandex
    new(api: YandexApi.new, topic_name: :yandex_topic)
  end

  def self.for_user
    new(api: UserApi.new, topic_name: :user_topic)
  end

  def process
    topic = @api.topic
    storage.public_send("#{topic_name}=", topic)
    current = storage.current_topic

    return if storage.previous_topic == current

    publish(current)
    storage.previous_topic = current
  end

  private

  def publish(topic)
    date = I18n.l Time.zone.parse(topic[:date]), format: :short
    ActionCable.server.broadcast('topics', topic: topic.merge(date: date))
  end
end
