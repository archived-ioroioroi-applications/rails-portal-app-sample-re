Rails.application.routes.draw do
  root 'top#index'
  
  get 'top/index'
  get 'top/index_list'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end