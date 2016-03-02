json.extract! relocation, :id, :origin_metro_area_id, :destination_metro_area_id  #, :name, :private, :description, :company_id, :status, :values, :issues_count, :open_issues_count, :primary_site_id, :report_tag_ids, :report_private_issues, :contract_id

json.frontend_organizaton_id relocation.organization_id
json.organization_id relocation.organization.access_id
json.frontend_agency_id relocation.agency_id
json.agency_id relocation.agency.access_id

json.employee do
  json.first_name relocation.employee.first_name
  json.last_name relocation.employee.last_name
  json.name relocation.employee.name
end

json.project do
  json.name relocation.project.name
end unless relocation.project.nil?

# json.role project.role_of(current_user)
#
# json.watching_status do
#   json.extract! project.watch_of(current_user), :all_tags, :tag_ids
#   json.watching project.watched_by?(current_user)
# end
#
# json.url project_path(project)
#
# json.scheduled_start project.scheduled_start.strftime('%Y-%m-%d') rescue ''
# json.actual_start project.actual_start.strftime('%Y-%m-%d') rescue ''
# json.scheduled_end project.scheduled_end.strftime('%Y-%m-%d') rescue ''
# json.actual_end project.actual_end.strftime('%Y-%m-%d') rescue ''
#
# json.company do
#   json.name project.company.name
#   json.id project.company.idr.pro
#   json.url company_path(project.company)
# end
#
# json.sites project.sites do |site|
#   json.extract! site, :id, :name, :address_line_1, :address_line_2, :city, :postal_code, :phone, :longitude, :latitude, :created_at, :updated_at
#   json.url site_company_path(site.company_id, site)
# end
#
# json.office do
#   json.extract! project.office, :id, :name, :address_line_1, :address_line_2, :city, :postal_code, :phone, :longitude, :latitude, :created_at, :updated_at
#   json.url site_company_path(project.office.company_id, project.office)
# end unless project.office.nil?
#
# json.equipment project.equipment do |equipment|
#   json.extract! equipment, :id, :identification, :description
#
#   json.url equipment_company_path(equipment.company, equipment)
#
#   json.company do
#     json.name equipment.company.name
#     json.id equipment.company.id
#   end
# end
#
# json.people project.project_users.includes(:user => { :employee => :company }) do |pu|
#   json.extract! pu.user, :id, :name, :created_at, :updated_at, :enabled
#
#   json.role pu.role
#
#   json.url user_company_path(pu.user.company, pu.user)
#
#   json.company do
#     json.name pu.user.company.name
#     json.id pu.user.company.id
#   end
#
#   json.watching_status do
#     json.extract! project.watch_of(pu.user), :all_tags, :tag_ids
#     json.watching project.watched_by?(pu.user)
#   end
# end
#
# json.tags project.tags, partial: 'tags/detail', as: :tag
#
# json.milestones project.milestones.order(due_at: :asc), partial: 'milestones/detail', as: :milestone
