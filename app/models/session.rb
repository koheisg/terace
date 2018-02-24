class Session
  include ActiveModel::Model

  attr_accessor :name, :password

  attr_reader :user

  validate :authenticate

  def save
    return true if valid?
    false
  end

  private

  def authenticate
    @user = User.find_by(name: name)
    errors.add(:base, 'authenticate was failed.') unless user&.authenticate(password)
  end
end
