Desk::Engine.routes.draw do
  root 'root#index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resource :site_session, only: :update

  resources :users
  resources :user_sites
  resources :sites
  resources :permalinks
  resources :categories
  resources :tags
  resources :histories, only: [:index, :show]
end
