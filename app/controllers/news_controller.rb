class NewsController < ApplicationController
  def index
    @topic = storage.current_topic
  end

  def admin
    @topic = UserTopic.new(storage.user_topic)
  end

  def update
    @topic = UserTopic.new(topic_params)
    if @topic.valid?
      NewsUpdater.new(storage: storage,
                      api: @topic,
                      topic_name: :user_topic).process
      YandexUpdateJob.set(wait_until: @topic.expire).perform_later
      redirect_back fallback_location: admin_path, notice: t('.success')
    else
      render :admin
    end
  end

  private

  def storage
    @storage ||= NewsStorage.new
  end

  def topic_params
    return @topic_params if @topic_params

    @topic_params = params.require(:user_topic)
                          .permit(:title, :text)
                          .merge(date: Time.zone.now)
    @topic_params[:expire] = expire_date_param
    @topic_params
  end

  def expire_date_param
    parts = (1..5).to_a.map { |x| params[:user_topic]["expire(#{x}i)"].to_i }
    Time.new(*parts).in_time_zone
  end
end
