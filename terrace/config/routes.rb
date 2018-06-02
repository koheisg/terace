Terrace::Engine.routes.draw do
  root to: 'articles#index'

  get '/:page', to: 'pages#index', page: /page\d+/
  get '/:permalink', to: 'articles#show', permalink: /[^\s]+/, as: :article
end
