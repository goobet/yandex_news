Rails.application.routes.draw do
  root to: 'news#index'
  get '/admin', to: 'news#admin', as: :admin
  post '/admin', to: 'news#update', as: :update
end
