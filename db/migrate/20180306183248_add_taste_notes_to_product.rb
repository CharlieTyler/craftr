class AddTasteNotesToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :dry_to_sweet, :integer
    add_column :products, :subtle_to_intense, :integer
    add_column :products, :fresh_to_complex, :integer
  end
end
