Rails.application.routes.draw do
  constraints(-> (req) { ENV['MAIN_DOMEIN'].eql?(req.host) }) do
    resources :sessions, only: [:new, :create, :destroy]
    resources :users
    resources :articles, expect: [:show]
    resources :tags
  end

  constraints(-> (req) { req.subdomain.present? }) do
    mount Terrace::Engine => "/"
  end
end
