RSpec.describe UserTopic do
  let(:topic) do
    { title: 'User test topic',
      text: 'Text',
      date: Time.zone.now,
      expire: Time.zone.now + 5.minutes }
  end

  let(:invalid_topic) do
    UserTopic.new(topic.merge(expire: topic[:expire] - 1.second))
  end

  subject(:user_topic) { UserTopic.new(topic) }

  describe '#topic' do
    it { expect(user_topic.topic).to eq topic }
  end

  it { expect(user_topic).to be_valid }
  it { expect(invalid_topic).to be_invalid }
end
