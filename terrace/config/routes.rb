Terrace::Engine.routes.draw do
  root to: 'articles#index'
  get '/:permalink', to: 'articles#show', permalink: /[^\s]+/
end
