class PermalinksController < ApplicationController
  before_action :set_permalink, only: [:show, :edit, :update, :destroy]

  # GET /permalinks
  # GET /permalinks.json
  def index
    @q = Permalink.new(params.permit(:path, :title, :state, :permalinkable_type))
    @permalinks = Permalink.includes(:site, :permalinkable)
                           .where(site: current_site)
                           .order(created_at: :desc)
                           .match_if(permalinkable_type: params[:permalinkable_type])
                           .match_if(state: params[:state])
                           .contains(title: params[:title])
                           .contains(path: params[:path])
                           .page(params[:page])
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
    @permalink = current_site.permalinks.new(permalink_params)
    @permalink.build_permalinkable unless @permalink.permalinkable

    respond_to do |format|
      if @permalink.save
        format.html { redirect_to @permalink, notice: 'Permalink was successfully created.' }
        format.json { render :show, status: :created, location: @permalink }
        format.js { render :create, status: :created }
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
        format.js { render :update, status: :created }
      else
        format.html { render :edit }
        format.json { render json: @permalink.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permalinks/1
  # DELETE /permalinks/1.json
  def destroy
    @permalink.permalinkable.destroy
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
      if params[:permalink][:permalinkable_type] == 'Article'
        params.require(:permalink).permit(:category_id, :permalinkable_type, :path, :title, :description, :noindex, :state, permalinkable_attributes: [:id, :content, :ogp_image, {images: []}, {tag_ids: []}])
      elsif params[:permalink][:permalinkable_type] == 'Page'
        params.require(:permalink).permit(:category_id, :permalinkable_type, :path, :title, :description, :noindex, :state, permalinkable_attributes: [:id, :content])
      elsif params[:permalink][:permalinkable_type] == 'Archive'
        params.require(:permalink).permit(:category_id, :permalinkable_type, :path, :title, :description, :noindex, :state, permalinkable_attributes: [:id])
      else
        params.require(:permalink).permit(:category_id, :permalinkable_type, :path, :title, :description)
      end
    end
end
