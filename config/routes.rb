Rails.application.routes.draw do
  root 'top#articles'

  get 'top/articles'
  get 'top/articles/:category' => 'top#articles'

  get '*not_found' => 'application#routing_error'
  post '*not_found' => 'application#routing_error'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
