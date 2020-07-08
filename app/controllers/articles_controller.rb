class ArticlesController < PermalinkableController
  before_action :set_article, only: [:edit, :update, :destroy, :show]

  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
    @article.build_permalink
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to [:edit, @article], notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
        format.js { render :create, status: :created }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
        format.js { render :error, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to [:edit, @article], notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok }
        format.js { head :ok }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
        format.js { render :error, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:content, :ogp_image, images: [], tag_ids: [],
                                      permalink_attributes: [:id, :site_id, :path, :title, :description, :state, :permalink, :noindex])
    end

    def search_params
      params.permit(Article::Search::ATTRIBUTES)
    end
end
