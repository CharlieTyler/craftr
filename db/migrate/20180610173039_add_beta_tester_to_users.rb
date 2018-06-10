class AddBetaTesterToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_beta_tester, :boolean, default: false
  end
end
