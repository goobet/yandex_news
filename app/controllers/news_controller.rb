class NewsController < ApplicationController

  def index
    @topic = storage.current_topic
  end

  def admin
    @topic = storage.user_topic
  end

  private

  def storage
    @storage ||= NewsStorage.new
  end
end
