class Article < ApplicationRecord
  include Auditable, Permalinkable, Htmlable

  has_many_attached :images
  has_one_attached :ogp_image
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
end
