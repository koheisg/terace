class Archive < ApplicationRecord
  include Auditable, Permalinkable

  belongs_to :archiveable, polymorphic: true
end
