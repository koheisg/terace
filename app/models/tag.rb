class Tag < ApplicationRecord
  include Archiveable

  has_many :taggings
  has_many :permalinks, through: :taggings, source: :taggable, source_type: 'Permalink'
  belongs_to :site

  validates :name, uniqueness: true
end
