class AddSlugToAuthors < ActiveRecord::Migration[5.1]
  def change
    unless column_exists? :authors, :slug
      add_column :authors, :slug, :string
    end
  end
end
