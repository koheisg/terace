module Fishur
  class Engine < ::Rails::Engine
    isolate_namespace Fishur
    config.generators.api_only = true
  end
end
