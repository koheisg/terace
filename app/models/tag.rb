class Tag < ApplicationRecord
  has_many :taggings, as: :taggable
  has_many :articles, through: :taggings, source: :taggable, source_type: 'Article'
  has_many :permalinks, through: :taggings, source: :taggable, source_type: 'Permalink'

  validates :name, uniqueness: true
end
