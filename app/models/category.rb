class Category < ApplicationRecord
  include Archiveable
  belongs_to :site
end
