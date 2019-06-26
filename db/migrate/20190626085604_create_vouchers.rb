class CreateVouchers < ActiveRecord::Migration[5.1]
  def change
    create_table :vouchers do |t|
      t.string :name
      t.string :code
      t.integer :value
      t.datetime :valid_from
      t.datetime :valid_to
      t.boolean :live
      t.timestamps
    end
  end
end
