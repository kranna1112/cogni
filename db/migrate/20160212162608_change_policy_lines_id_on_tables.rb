class ChangePolicyLinesIdOnTables < ActiveRecord::Migration
  def change
    rename_column :relocation_benefits, :policy_line_id, :policy_benefit_id
  end
end
