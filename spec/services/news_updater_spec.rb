RSpec.describe NewsUpdater do
  let(:storage) { NewsStorage.new }

  describe '#process' do
    describe 'yandex' do
      let(:topic) do
        { title: 'Yandex test topic',
          text: 'Text',
          date: Time.zone.now.change(sec: 0) }
      end

      subject(:updater) do
        described_class.new(storage: storage,
                            api: OpenStruct.new(topic: topic),
                            topic_name: :yandex_topic)
      end

      it 'sets current topic' do
        updater.process
        expect(storage.current_topic).to eq topic.stringify_keys
      end
    end

    describe 'user' do
      let(:topic) do
        { title: 'User test topic',
          text: 'Text',
          date: Time.zone.now.change(sec: 0),
          expire: Time.zone.now.change(sec: 0) + 5.minutes }
      end

      subject(:updater) do
        described_class.new(storage: storage,
                            api: OpenStruct.new(topic: topic),
                            topic_name: :user_topic)
      end

      it 'sets current topic' do
        updater.process
        expect(storage.current_topic).to eq topic.stringify_keys
      end

      it 'publishes if topic was changed' do
        expect(ActionCable.server).to receive(:broadcast)
        updater.process
      end

      it "don't publish if topic wasn't changed" do
        updater.process
        expect(ActionCable.server).not_to receive(:broadcast)
        updater.process
      end
    end
  end
end
