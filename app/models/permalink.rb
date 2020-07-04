class Permalink < ApplicationRecord
  belongs_to :permalinkable, polymorphic: true
  belongs_to :site

  enum state: { draft: 0, shipped: 1 }

  scope :published, -> { shipped.where('permalinks.published_at <= ?', Time.current) }
end
