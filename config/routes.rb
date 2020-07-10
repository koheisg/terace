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
    resources :tags
    resources :histories, only: [:index, :show]
  end

  constraints(-> (req) { req.subdomain.present? }) do
    mount Terrace::Engine => "/"
  end

  get '/', to: redirect { |_p, r| "http://#{ENV['MAIN_DOMEIN']}:#{r.port}/" } if Rails.env.development?
end
