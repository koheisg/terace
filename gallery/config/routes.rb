Terrace::Engine.routes.draw do
  get '/:permalink', to: 'permalinks#show', permalink: /.*/, as: :article
end
