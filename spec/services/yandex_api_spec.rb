RSpec.describe YandexApi do
  let(:topic) do
    { title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
      text: 'Ut enim ad minim veniam, quis nostrud exercitation ullamco',
      date: Time.zone.now.change(hour: 13, min: 38) }
  end

  it 'returns correct topic' do
    expect(YandexApi.new.topic).to eq(topic)
  end
end
