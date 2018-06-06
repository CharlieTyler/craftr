class AddAcceptPrivacyPolicyToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :privacy_policy_accepted, :string, default: false
  end
end
