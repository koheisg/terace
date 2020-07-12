class Article < ApplicationRecord
  include Auditable, Permalinkable, Htmlable

  has_many_attached :images
  has_one_attached :ogp_image
end
