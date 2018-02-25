class Articles::UsersController < ApplicationController
  skip_before_action :verify_user

  def index
    @user = User.find_by!(name: params[:user_name])
    @articles = @user.articles.published
  end
end
