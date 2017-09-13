RSpec.describe NewsController do
  describe 'GET index' do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'GET admin' do
    let(:user_topic) do
      { title: 'User test topic',
        text: 'Text',
        date: Time.zone.now,
        expire: Time.zone.now + 5.minutes }
    end

    it 'has a 200 status code' do
      get :admin
      expect(response.status).to eq(200)
    end

    it 'assigns already existance topic' do
      expect_any_instance_of(NewsStorage).to receive(:user_topic)
        .and_return(user_topic)
      get :admin
      expect(assigns(:topic).topic).to eq(user_topic)
    end
  end

  describe 'PATCH update' do
    let(:params) do
      {
        user_topic: {
          title: 'test',
          text: 'test'
        }.merge(time_to_params(Time.zone.now + 10.minutes))
      }
    end

    let(:wrong_params) do
      {
        user_topic: {
          title: 'test',
          text: 'test'
        }.merge(time_to_params(Time.zone.now - 10.minutes))
      }
    end

    it 'redirect to admin if params correct' do
      expect(patch(:update, params: params)).to redirect_to action: :admin
    end

    it 'renders admin' do
      expect(patch(:update,
                   params: wrong_params)).not_to redirect_to action: :admin
    end
  end

  def time_to_params(time)
    { 'expire(1i)' => time.year,
      'expire(2i)' => time.month,
      'expire(3i)' => time.day,
      'expire(4i)' => time.hour,
      'expire(5i)' => time.min }
  end
end
