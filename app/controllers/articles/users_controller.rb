class Articles::UsersController < ApplicationController
  skip_before_action :verify_user

  def index
    @user = User.find_by!(name: request.subdomain)
    @articles = @user.articles.published
  end
end
