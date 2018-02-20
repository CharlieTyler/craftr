class ArticleRecipe < ApplicationRecord
  belongs_to :article
  belongs_to :recipe
end
