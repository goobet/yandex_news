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

  def user_topic=(topic)
    expire = (topic[:expire] - Time.zone.now).to_i
    update_field(:user_topic, topic, expire: expire)
  end

  def yandex_topic=(topic)
    update_field(:yandex_topic, topic)
  end

  def self.redis
    @redis ||= Redis.new(url: ENV.fetch('REDIS_URL', 'redis://127.0.0.1:6379'))
  end

  private

  def fetch_field(name)
    json = self.class.redis.get(name)
    JSON.parse(json).with_indifferent_access if json
  end

  def update_field(name, value, expire: nil)
    self.class.redis.set(name, value.to_json, ex: expire)
    value
  end
end
