class Site < ApplicationRecord
  has_many :articles
  has_many :user_sites
  has_many :users, through: :user_sites
end
