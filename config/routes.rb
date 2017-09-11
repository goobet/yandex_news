Rails.application.routes.draw do
  root to: 'news#index'
  get '/admin', to: 'news#admin'
end
