class ChangeAcceptedPrivacyPolicyToBoolean < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :privacy_policy_accepted
    add_column :users, :privacy_policy_accepted, :boolean, default: false
  end
end
