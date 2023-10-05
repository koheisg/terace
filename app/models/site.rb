class Site < ApplicationRecord
  include Archiveable
  has_many :permalinks, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :articles, through: :permalinks
  has_many :user_sites, dependent: :destroy
  has_many :users, through: :user_sites

  enum layout: [:default, :dev]

  def prose
    dev? ? 'prose prose-invert' : 'prose'
  end

  def author
    name == 'forward' ? 'forward inc.' : 'koheisg'
  end
end
