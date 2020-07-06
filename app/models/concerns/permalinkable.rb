module Permalinkable
  extend ActiveSupport::Concern

  included do
    has_one :permalink, as: :permalinkable, dependent: :destroy
    accepts_nested_attributes_for :permalink
    delegate :site, :noindex?, :draft?, :shipped?, :title, :description, :path, to: :permalink
  end
end
