Rails.application.routes.draw do
  constraints(-> (req) { ENV['MAIN_DOMEIN'].eql?(req.host) }) do
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
    resources :archives, except: [:index]
    resources :pages, except: [:index]
    resources :articles, except: [:index] do
      resources :histories, module: :articles, only: [:index, :show]
    end
    resources :tags
  end

  constraints(-> (req) { req.subdomain.present? }) do
    mount Terrace::Engine => "/"
  end

  get '/', to: redirect { |_p, r| "http://#{ENV['MAIN_DOMEIN']}:#{r.port}/" } if Rails.env.development?
end
