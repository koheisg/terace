Rails.application.routes.draw do
  constraints(-> (req) { ENV['MAIN_DOMEIN'].eql?(req.host) }) do
    resources :sessions, only: [:new, :create, :destroy]
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
