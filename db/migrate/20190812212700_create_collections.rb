class CreateCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :collections do |t|
      t.string :name
      t.text :description
      t.string :image
      t.string :category_id
      t.boolean :featured
      t.timestamps
    end
  end
end
