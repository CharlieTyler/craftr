class CreateCarouselFeatures < ActiveRecord::Migration[5.1]
  def change
    create_table :carousel_features do |t|
      t.string :line_1
      t.string :line_2
      t.string :cta_text
      t.string :link_url
      t.string :image
      t.timestamps
    end
  end
end
