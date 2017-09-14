RSpec.describe NewsStorage do
  subject(:storage) { described_class.new }

  describe '#current_topic' do
    let(:yandex_topic) do
      { title: 'Yandex test topic',
        text: 'Text',
        date: Time.zone.now.change(sec: 0) }
    end

    let(:user_topic) do
      { title: 'User test topic',
        text: 'Text',
        date: Time.zone.now.change(sec: 0),
        expire: Time.zone.now.change(sec: 0) + 5.minutes }
    end

    it 'returns yandex topic if no user topic' do
      storage.yandex_topic = yandex_topic
      expect(storage.current_topic).to eq(yandex_topic.stringify_keys)
    end

    it 'returns usert topic if user topic present' do
      storage.yandex_topic = yandex_topic
      storage.user_topic = user_topic
      expect(storage.current_topic).to eq(user_topic.stringify_keys)
    end
  end

  describe '#user_topic' do
    let(:topic) do
      { title: 'User test topic',
        text: 'Text',
        date: Time.zone.now.change(sec: 0),
        expire: Time.zone.now.change(sec: 0) + 2.seconds }
    end

    it 'sets user topic' do
      storage.user_topic = topic
      expect(storage.user_topic).to eq(topic.stringify_keys)
    end
  end
end
