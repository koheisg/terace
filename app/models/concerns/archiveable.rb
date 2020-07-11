module Archiveable
  extend ActiveSupport::Concern

  included do
    has_one :archive, as: :archiveable, dependent: :destroy
    has_many :permalinks
  end
end
