Terrace::Engine.routes.draw do
  get :feed, to: 'rss#index', defaults: { format: :rss }

  get '/:page', to: 'pages#index', page: /page\d+/
  get '/:permalink', to: 'permalinks#show', permalink: /.*/, as: :article
end
