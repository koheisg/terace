require_dependency "desk/application_controller"

module Desk
class UserSitesController < ApplicationController
  before_action :set_user_site, only: [:show, :edit, :update, :destroy]

  # GET /user_sites
  # GET /user_sites.json
  def index
    @user_sites = UserSite.all
  end

  # GET /user_sites/1
  # GET /user_sites/1.json
  def show
  end

  # GET /user_sites/new
  def new
    @user_site = UserSite.new
  end

  # GET /user_sites/1/edit
  def edit
  end

  # POST /user_sites
  # POST /user_sites.json
  def create
    @user_site = UserSite.new(user_site_params)

    respond_to do |format|
      if @user_site.save
        format.html { redirect_to @user_site, notice: 'User site was successfully created.' }
        format.json { render :show, status: :created, location: @user_site }
      else
        format.html { render :new }
        format.json { render json: @user_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_sites/1
  # PATCH/PUT /user_sites/1.json
  def update
    respond_to do |format|
      if @user_site.update(user_site_params)
        format.html { redirect_to @user_site, notice: 'User site was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_site }
      else
        format.html { render :edit }
        format.json { render json: @user_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_sites/1
  # DELETE /user_sites/1.json
  def destroy
    @user_site.destroy
    respond_to do |format|
      format.html { redirect_to user_sites_url, notice: 'User site was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_site
      @user_site = UserSite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_site_params
      params.require(:user_site).permit(:user_id, :site_id)
    end
end
end