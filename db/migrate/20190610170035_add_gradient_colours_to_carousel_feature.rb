class AddGradientColoursToCarouselFeature < ActiveRecord::Migration[5.1]
  def change
    remove_column :carousel_features, :floating_square_image, :string
    add_column :carousel_features, :gradient_from, :string
    add_column :carousel_features, :gradient_to, :string
  end
end
