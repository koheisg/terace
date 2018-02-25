Rails.application.routes.draw do
  constraints(-> (req) { req.subdomain.present? }) do
    root to: 'articles/users#index'
    get '/:permalink', to: 'articles#show', permalink: /[^\s]+/
  end

  constraints(-> (req) { req.subdomain.blank? }) do
    resources :sessions, only: [:new, :create, :destroy]
    resources :users
    resources :articles, expect: [:index, :show]
  end
end
