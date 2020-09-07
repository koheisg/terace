Fishur::Engine.routes.draw do
  get :feed, to: 'rss#index', defaults: { format: :rss }
end
