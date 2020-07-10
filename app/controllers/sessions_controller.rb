class SessionsController < ApplicationController
  skip_before_action :verify_user
  before_action :redirect_to_permalinks_if_login, only: [:new, :create]
  # GET /sessions/new
  def new
    @session = Session.new
  end

  # POST /sessions
  # POST /sessions.json
  def create
    @session = Session.new(session_params)

    respond_to do |format|
      if @session.save
        reset_session
        session[:user_id] = @session.user.id
        format.html { redirect_to root_path, notice: 'Login success!' }
        format.json { render :show, status: :created, location: @session }
      else
        format.html { render :new }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out"
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def session_params
      params.require(:session).permit(:name, :password)
    end

    def redirect_to_permalinks_if_login
      redirect_to permalinks_path if login?
    end
end
