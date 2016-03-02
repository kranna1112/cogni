class RemoveBackendOrganizationIdFromOrganization < ActiveRecord::Migration
  def change
    remove_column :organizations, :backend_organization_id, :integer
  end
end
