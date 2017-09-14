class NewsUpdater
  attr_accessor :storage, :api, :topic_name

  def initialize(storage: NewsStorage.new, api:, topic_name:)
    @storage = storage
    @api = api
    @topic_name = topic_name
  end

  def process
    topic = @api.topic
    storage.public_send("#{topic_name}=", topic)

    current = storage.current_topic
    previous = storage.previous_topic

    return if previous.present? && previous == current

    publish(current)
    storage.previous_topic = current
  end

  private

  def publish(topic)
    date = I18n.l topic[:date], format: :short
    ActionCable.server.broadcast('topics', topic: topic.merge(date: date))
  end
end
