class NewsStorage
  def current_topic
    user_topic || yandex_topic
  end

  def user_topic
    fetch_field(:user_topic)
  end

  def yandex_topic
    fetch_field(:yandex_topic)
  end

  def previous_topic
    fetch_field(:previous_topic)
  end

  def previous_topic=(topic)
    assign_topic(:previous_topic, topic)
  end

  def user_topic=(topic)
    assign_topic(:user_topic, topic)
  end

  def yandex_topic=(topic)
    assign_topic(:yandex_topic, topic)
  end

  def assign_topic(topic_name, topic)
    if topic_name == :user_topic
      expire = (topic[:expire] - Time.zone.now).to_i
      return update_field(:user_topic, topic, expire: expire)
    end

    update_field(topic_name, topic)
  end

  def self.redis
    @redis ||= Redis.new(url: ENV.fetch('REDIS_URL', 'redis://127.0.0.1:6379'))
  end

  private

  def fetch_field(name)
    json = self.class.redis.get(name)
    return if json.blank?

    parsed_topic = JSON.parse(json).with_indifferent_access
    %i[date expire].each do |attribute|
      next if parsed_topic[attribute].blank?

      parsed_topic[attribute] = Time.zone.iso8601(parsed_topic[attribute])
    end

    parsed_topic
  end

  def update_field(name, value, expire: nil)
    self.class.redis.set(name, value.to_json, ex: expire)
    value
  end
end
