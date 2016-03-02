class AddCatalogIdToPolicy < ActiveRecord::Migration
  def change
    add_column :policies, :catalog_id, :integer, index: true
  end
end
