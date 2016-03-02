class AddPolicyIdToPolicyLine < ActiveRecord::Migration
  def change
    add_reference :policy_lines, :policy, index: true, null: false
  end
end
