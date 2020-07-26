class Audit < ApplicationRecord
  belongs_to :auditable, polymorphic: true
  serialize :modifications

  validates :modifications, :action, presence: true
end
