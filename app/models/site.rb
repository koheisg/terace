class Site < ApplicationRecord
  has_many :permalinks
  has_many :categories
  has_many :articles, through: :permalinks
  has_many :user_sites
  has_many :users, through: :user_sites

  enum layout: [:default, :dev, :forward]
end
