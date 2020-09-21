module Terrace
  class Engine < ::Rails::Engine
    isolate_namespace Terrace

    config.exceptions_app = ActionDispatch::PublicExceptions.new(Terrace::Engine.root.join('public'))
  end
end
