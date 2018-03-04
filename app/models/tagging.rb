class Tagging < ApplicationRecord
  belongs_to :tags
  belongs_to :taggable, polymorphic: true
end
