class RenamePolicyLine < ActiveRecord::Migration
  def change
    rename_table :policy_lines, :policy_benefits
  end
end
