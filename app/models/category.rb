class Category < ApplicationRecord
  include Archiveable
  has_many :permalinks, dependent: :nullify
  belongs_to :site
end
