class AddBackendOrganizationIdToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :backend_organization_id, :integer
  end
end
