class Archive < ApplicationRecord
  include Auditable, Permalinkable

  belongs_to :archiveable, polymorphic: true, optional: true

  def permalinks
    archiveable.permalinks.includes(:permalinkable).article_types.published.order(published_at: :desc)
  end
end
