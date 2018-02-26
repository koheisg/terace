Rails.application.routes.draw do
  constraints(-> (req) { req.subdomain.present? }) do
    mount Terrace::Engine => "/"
  end

  constraints(-> (req) { req.subdomain.blank? }) do
    resources :sessions, only: [:new, :create, :destroy]
    resources :users
    resources :articles, expect: [:index, :show]
  end
end
