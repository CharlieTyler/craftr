class UserArticleView < ApplicationRecord
  belongs_to :user, required: false
  belongs_to :article, counter_cache: true
end
