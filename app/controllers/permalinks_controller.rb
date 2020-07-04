class PermalinksController < ApplicationController
  before_action :set_permalink, only: [:show, :edit, :update, :destroy]

  # GET /permalinks
  # GET /permalinks.json
  def index
    @permalinks = Permalink.all
  end

  # GET /permalinks/1
  # GET /permalinks/1.json
  def show
  end

  # GET /permalinks/new
  def new
    @permalink = Permalink.new
  end

  # GET /permalinks/1/edit
  def edit
  end

  # POST /permalinks
  # POST /permalinks.json
  def create
    @permalink = Permalink.new(permalink_params)

    respond_to do |format|
      if @permalink.save
        format.html { redirect_to @permalink, notice: 'Permalink was successfully created.' }
        format.json { render :show, status: :created, location: @permalink }
      else
        format.html { render :new }
        format.json { render json: @permalink.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /permalinks/1
  # PATCH/PUT /permalinks/1.json
  def update
    respond_to do |format|
      if @permalink.update(permalink_params)
        format.html { redirect_to @permalink, notice: 'Permalink was successfully updated.' }
        format.json { render :show, status: :ok, location: @permalink }
      else
        format.html { render :edit }
        format.json { render json: @permalink.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permalinks/1
  # DELETE /permalinks/1.json
  def destroy
    @permalink.destroy
    respond_to do |format|
      format.html { redirect_to permalinks_url, notice: 'Permalink was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_permalink
      @permalink = Permalink.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def permalink_params
      params.require(:permalink).permit(:permalinkable_id, :permalinkable_type, :site_id, :path, :title, :description, :noindex, :published_at, :modified_at)
    end
end
