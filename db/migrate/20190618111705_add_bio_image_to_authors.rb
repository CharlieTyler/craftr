class AddBioImageToAuthors < ActiveRecord::Migration[5.1]
  def change
    add_column :authors, :bio_image, :string
  end
end
