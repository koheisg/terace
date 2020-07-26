class PermalinksController < ApplicationController
  before_action :set_permalink, only: [:show, :edit, :update, :destroy]

  PRE_PAGE = 100

  # GET /permalinks
  # GET /permalinks.json
  def index
    search_params = params.fetch(:permalink, {}).permit(:path, :title, :state, :permalinkable_type, :category_id, {tag_ids: []})
    @q = Permalink.new(search_params)
    @permalinks = Permalink.includes(:site, :category, :tags)
                           .preload(:permalinkable)
                           .where(site: Current.site)
                           .order(created_at: :desc)
                           .match_if(permalinkable_type: search_params[:permalinkable_type])
                           .match_if(category_id: search_params[:category_id])
                           .match_if(state: search_params[:state])
                           .contains(title: search_params[:title])
                           .contains(path: search_params[:path])
                           .match_if_tag_ids(search_params[:tag_ids])
                           .page(params[:page])
                           .per(PRE_PAGE)
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
    @permalink = Current.site.permalinks.new(permalink_params)
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
      format.js { render :destroy, status: :ok }
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
        params.require(:permalink).permit(:category_id, :permalinkable_type, :path, :title, :description, :noindex, :state, {tag_ids: []},
                                          permalinkable_attributes: [:id, :content, :ogp_image, {images: []}])
      elsif params[:permalink][:permalinkable_type] == 'Page'
        params.require(:permalink).permit(:category_id, :permalinkable_type, :path, :title, :description, :noindex, :state, {tag_ids: []},
                                          permalinkable_attributes: [:id, :content])
      elsif params[:permalink][:permalinkable_type] == 'Archive'
        params.require(:permalink).permit(:category_id, :permalinkable_type, :path, :title, :description, :noindex, :state, {tag_ids: []},
                                          permalinkable_attributes: [:id, :archiveable_type, :archiveable_id])
      else
        params.require(:permalink).permit(:category_id, :path, :title, :description, :noindex, :state, {tag_ids: []})
      end
    end
end
