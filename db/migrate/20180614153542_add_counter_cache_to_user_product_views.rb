class AddCounterCacheToUserProductViews < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :user_product_views_count, :integer
  end
end
