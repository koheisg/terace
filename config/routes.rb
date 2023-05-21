Rails.application.routes.draw do
  constraints(-> (req) { ENV['MAIN_DOMEIN'].eql?(req.host) }) do
    scope module: 'desk' do
      root to: 'root#index'
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
  end
  constraints(-> (req) { req.subdomain.present? }) do
    get :feed, to: 'fishur/rss#index', defaults: { format: :rss }
  end

  constraints(-> (req) { req.subdomain.present? }) do
    get '/', to: 'public/permalinks#show'
    get '/:permalink', to: 'public/permalinks#show', permalink: /.*/, as: :article
  end

  get '/', to: redirect { |_p, r| "http://#{ENV['MAIN_DOMEIN']}:#{r.port}/" } if Rails.env.development?
end
