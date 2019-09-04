class Search




  def initialize(params)
    @params = params
  end

  def results
    {
      products: Product.transactional.search(@params).all,
      recipes: Recipe.search(@params).all,
      articles: Article.search(@params).all,
      distilleries: Distillery.transactional.search(@params).all,
    }

  end

  # def results_combined
  #   Product.search(@params).all +
  #     Article.search(@params).all +
  #     Recipe.search(@params).all
  # end 
end


# Search.new(params).results

# =>
# {
#   products: [],
#   articles: [],
#   recipes: [],
# }