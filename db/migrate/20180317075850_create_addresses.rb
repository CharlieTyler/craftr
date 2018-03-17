class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :line_1
      t.string :line_2
      t.string :line_3
      t.string :post_town
      t.string :postcode
      t.timestamps
    end
  end
end
