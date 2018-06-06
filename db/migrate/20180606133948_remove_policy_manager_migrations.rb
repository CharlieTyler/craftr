class RemovePolicyManagerMigrations < ActiveRecord::Migration[5.1]
  def change
    drop_table :policy_manager_terms
    drop_table :policy_manager_user_terms
  end
end
