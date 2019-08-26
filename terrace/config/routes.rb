Terrace::Engine.routes.draw do
  root to: 'articles#index'
  get :feed, to: 'rss#index', defaults: { format: :rss }

  get '/:page', to: 'pages#index', page: /page\d+/
  get '/ogp/:permalink', to: 'articles/ogp#show', permalink: /[^\s]+/, as: :ogp
  get '/:permalink', to: 'articles#show', permalink: /[^\s]+/, as: :article
end
