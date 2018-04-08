class Admin::ArticlesController < AdminController
  def new
    @article = Article.new

    #build joins
    @article.article_categories.build
    @article.article_distilleries.build
    @article.article_products.build
    @article.article_recipes.build
    
    #options for joins
    @authors = Author.all
    @categories = Category.all
    @distilleries = Distillery.all
    @products = Product.all
    @recipes = Recipe.all
  end

  def create
    @article = Article.create(article_params)
    if @article.valid?
      redirect_to article_path(@article)
    else
      return render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.friendly.find(params[:id])

    #build joins
    @article.article_categories.build
    @article.article_distilleries.build
    @article.article_products.build
    @article.article_recipes.build
    
    #options for joins
    @authors = Author.all
    @categories = Category.all
    @distilleries = Distillery.all
    @products = Product.all
    @recipes = Recipe.all
  end

  def update
    @article = Article.friendly.find(params[:id])
    @article.update_attributes(article_params)
    if @article.valid?
      redirect_to article_path(@article)
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.friendly.find(params[:id])
    @article.delete
    flash[:alert] = "Article successfully deleted"
    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(:title,
                                    :description,
                                    :tag_list,
                                    :banner_image,
                                    :image_first,
                                    :image_second,
                                    :image_third,
                                    :image_fourth,
                                    :image_fifth,
                                    :description_first,
                                    :description_second,
                                    :description_third,
                                    :description_fourth,
                                    :description_fifth,
                                    :author_id,
                                    article_categories_attributes: [:id, :category_id, :article_id],
                                    article_distilleries_attributes: [:id, :distillery_id, :article_id],
                                    article_products_attributes: [:id, :product_id, :article_id],
                                    article_recipes_attributes: [:id, :recipe_id, :article_id]
                                    )
  end
end
