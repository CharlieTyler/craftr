class CreateCollectionProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :collection_products do |t|

      t.timestamps
    end
  end
end
