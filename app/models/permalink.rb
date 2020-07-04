class Permalink < ApplicationRecord
  belongs_to :permalinkable, polymorphic: true
  belongs_to :site
end
