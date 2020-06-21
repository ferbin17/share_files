Rails.application.routes.draw do
  root to: 'welcome#index'
  post 'uploads/chunk_create'
  post 'uploads/set_users'
  resources :users
  resources :uploads
  resources :downloads
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
