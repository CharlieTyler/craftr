class AddRowOrderToCarouselFeature < ActiveRecord::Migration[5.1]
  def change
    add_column :carousel_features, :row_order, :integer
    add_index :carousel_features, :row_order
  end
end
