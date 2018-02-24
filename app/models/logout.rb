class Logout
  delegate_missing_to :@user

  def initialize
    @user = User.new
  end
end
