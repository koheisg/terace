Rails.application.routes.draw do
  namespace :articles do
    get 'histories/index'
    get 'histories/show'
  end
  constraints(-> (req) { ENV['MAIN_DOMEIN'].eql?(req.host) }) do
    root 'root#index'

    controller :sessions do
      get 'login' => :new
      post 'login' => :create
      delete 'logout' => :destroy
    end

    resources :users
    resources :articles, expect: [:show] do
      collection do
        resources :drafts, only: :index, module: :articles
        resources :published, only: :index, module: :articles
        get :search, to: 'articles/search#index', as: :search
      end
    end
    resources :tags
  end

  constraints(-> (req) { req.subdomain.present? }) do
    mount Terrace::Engine => "/"
  end
end
