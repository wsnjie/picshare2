Rails.application.routes.draw do
  post '/incoming', to: 'messages#incoming'
  get '/pics', to: 'pics#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepage#index'
end
