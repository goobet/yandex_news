require './config/boot'
require './config/environment'

require 'clockwork'

module Clockwork
  every(1.minute, 'yandex_update.job') do
    YandexUpdateJob.perform_later
  end
end
