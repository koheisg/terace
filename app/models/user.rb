class User < ApplicationRecord
  has_secure_password
  has_many :articles

  def host
    "koheisg.lvh.me:3000"
  end
end
