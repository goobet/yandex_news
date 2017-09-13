class UserTopic
  include ActiveModel::Model

  attr_accessor :title, :text, :date, :expire

  validates :title, :text, :date, :expire, presence: true

  validate :expiration_date_cannot_be_in_the_past

  def topic
    { title: title,
      text: text,
      date: date,
      expire: expire }
  end

  private

  def expiration_date_cannot_be_in_the_past
    return if expire.blank? || expire > Time.zone.now

    errors.add(:expire, :cant_be_in_the_past)
  end
end
