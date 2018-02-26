Rails.application.routes.draw do
  constraints(-> (req) { req.subdomain.present? }) do
    mount Terrace::Engine => "/"
  end

  constraints(-> (req) { %w[lvh.me terace.herokuapp.com].include?(req.host) }) do
    resources :sessions, only: [:new, :create, :destroy]
    resources :users
    resources :articles, expect: [:index, :show]
  end
end
