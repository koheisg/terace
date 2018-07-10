class Site < ApplicationRecord
  has_many :articles
  has_many :users, through: :user_sites
end
