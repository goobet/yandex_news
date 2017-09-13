class NewsController < ApplicationController
  def index
    @topic = storage.current_topic
  end

  def admin
    @topic = UserTopic.new(topic_from_storage)
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
    @topic_params[:expire] = Time.new(
      params[:user_topic]['expire(1i)'].to_i,
      params[:user_topic]['expire(2i)'].to_i,
      params[:user_topic]['expire(3i)'].to_i,
      params[:user_topic]['expire(4i)'].to_i,
      params[:user_topic]['expire(5i)'].to_i
    ).in_time_zone
    @topic_params
  end

  def topic_from_storage
    topic = storage.user_topic
    return unless topic
    expire = Time.zone.parse(storage.user_topic[:expire])
    topic.merge(expire: expire)
  end
end
