Rails.application.routes.draw do
  constraints(-> (req) { ENV['MAIN_DOMEIN'].eql?(req.host) }) do
    root 'root#index'
    controller :sessions do
      get 'login' => :new
      post 'login' => :create
      delete 'logout' => :destroy
    end

    resources :users
    resources :user_sites
    resources :sites
    resources :articles, expect: [:show] do
      collection do
        resources :drafts, only: :index, module: :articles
        resources :published, only: :index, module: :articles
        get :search, to: 'articles/search#index', as: :search
      end

      resources :histories, module: :articles, only: [:index, :show]
    end
    resources :tags
  end

  constraints(-> (req) { req.subdomain.present? }) do
    mount Terrace::Engine => "/"
  end

  get '/', to: redirect { |_p, r| "http://#{ENV['MAIN_DOMEIN']}:#{r.port}/" } if Rails.env.development?
end
