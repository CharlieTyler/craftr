class AddSquarePhotoToFeatureCarousel < ActiveRecord::Migration[5.1]
  def change
    add_column :carousel_features, :floating_square_image, :string
  end
end
