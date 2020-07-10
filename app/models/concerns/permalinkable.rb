module Permalinkable
  extend ActiveSupport::Concern

  included do
    has_one :permalink, as: :permalinkable, dependent: :destroy
    delegate :site, :noindex?, :draft?, :shipped?, :title, :description, :path, to: :permalink
  end
end
