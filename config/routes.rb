Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root to: "ideas#index"
    # root 'ideas#index'
    # get '/' => 'ideas#index', as: :root
  resources :users, only:[:new,
                          :create,
                          :update]
  get 'update' => 'users#edit'
  patch 'update' => 'users#update'

  resources :ideas do
    resources :reviews, shallow: true
  end

  resources :sessions, only:[:new, :create] do
    delete :destroy, on: :collection
  end

end
