class User < ApplicationRecord
  has_secure_password
  has_many :user_sites, dependent: :destroy
  has_many :sites, through: :user_sites
end
