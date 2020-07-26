class Current < ActiveSupport::CurrentAttributes
  attribute :user
  attribute :site

  delegate :categories, :tags, to: :site, prefix: true
end
