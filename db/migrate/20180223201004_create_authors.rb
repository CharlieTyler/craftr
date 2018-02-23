class CreateAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :authors do |t|
      t.string :website
      t.string :instagram
      t.text :description
      t.timestamps
    end
  end
end
