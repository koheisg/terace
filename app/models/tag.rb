class Tag < ApplicationRecord
  has_many :taggings, as: :taggable
  has_many :articles, through: :taggings, source: :taggable, source_type: 'Article'

  validates :name, uniqueness: true
end
