class NewsUpdater
  attr_accessor :storage, :topic_provider, :topic_name

  def initialize(storage: NewsStorage.new, topic_provider:, topic_name:)
    @storage = storage
    @topic_provider = topic_provider
    @topic_name = topic_name
  end

  def process
    topic = @topic_provider.topic
    storage.assign_topic(topic_name, topic)

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
