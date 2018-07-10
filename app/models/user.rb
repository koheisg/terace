class User < ApplicationRecord
  has_secure_password
  has_many :articles
  has_many :user_sites
  has_many :sites, through: :user_sites
end
