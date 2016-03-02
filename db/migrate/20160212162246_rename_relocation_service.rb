class RenameRelocationService < ActiveRecord::Migration
  def change
    rename_table :relocation_services, :relocation_benefits
  end
end
