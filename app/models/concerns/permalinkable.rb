module Permalinkable
  extend ActiveSupport::Concern

  included do
    has_one :permalink, as: :permalinkable
  end
end
