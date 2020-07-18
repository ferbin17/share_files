Rails.application.routes.draw do
  root to: 'uploads#index'
  resources :file_senders, except: [:index, :new, :edit, :update, :destroy] do
  end
  resources :uploads, except: [:new, :edit, :update, :destroy, :show] do 
    collection do 
      post 'chunk_create'
      post 'set_users'
      post 'cancel_upload'
    end
    member do
    end
  end
  resources :downloads, except: [:index, :new, :create, :edit, :update, :destroy] do
    member do
      get 'download'
      get 'download_as_zip'
    end
  end
  get '*unmatched_route', to: 'application#raise_not_found'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
