module Permalinkable
  extend ActiveSupport::Concern

  included do
    has_one :permalink, as: :permalinkable, dependent: :destroy
    accepts_nested_attributes_for :permalink
  end
end
