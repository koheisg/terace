Terrace::Engine.routes.draw do
  get :feed, to: 'rss#index', defaults: { format: :rss }
  get '/:permalink', to: 'permalinks#show', permalink: /.*/, as: :article
end
