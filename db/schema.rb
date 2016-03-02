# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160214223244) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "addresses", force: :cascade do |t|
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.string   "address_1"
    t.string   "address_2"
    t.integer  "country_id"
    t.integer  "subdivision_id"
    t.integer  "metro_area_id"
    t.integer  "postal_code_id"
    t.string   "postal_code"
    t.integer  "city_id"
    t.string   "city"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "addresses", ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id", using: :btree

  create_table "attachments", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.string   "name"
    t.string   "content_type"
    t.integer  "file_size"
    t.integer  "creator_id"
    t.string   "status"
    t.string   "acl",             default: "public_read"
    t.string   "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["organization_id", "attachable_id", "attachable_type"], name: "index_attachable_on_attachments", using: :btree

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.string   "request_uuid"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], name: "associated_index", using: :btree
  add_index "audits", ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
  add_index "audits", ["created_at"], name: "index_audits_on_created_at", using: :btree
  add_index "audits", ["request_uuid"], name: "index_audits_on_request_uuid", using: :btree
  add_index "audits", ["user_id", "user_type"], name: "user_index", using: :btree

  create_table "bundles", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "entity_type"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bundles", ["entity_type"], name: "index_bundles_on_entity_type", using: :btree
  add_index "bundles", ["name"], name: "index_bundles_on_name", using: :btree
  add_index "bundles", ["organization_id"], name: "index_bundles_on_organization_id", using: :btree

  create_table "employees", force: :cascade do |t|
    t.integer  "organization_id"
    t.integer  "user_id"
    t.string   "first_name",                    null: false
    t.string   "middle_name"
    t.string   "last_name",                     null: false
    t.hstore   "property_values"
    t.integer  "relocations_count", default: 0, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "employees", ["organization_id"], name: "index_employees_on_organization_id", using: :btree
  add_index "employees", ["user_id"], name: "index_employees_on_user_id", using: :btree

  create_table "estimates", force: :cascade do |t|
    t.integer  "relocation_id",                  null: false
    t.string   "status"
    t.text     "comments"
    t.integer  "total_cents",    default: 0,     null: false
    t.string   "total_currency", default: "USD", null: false
    t.datetime "calculated_at"
    t.integer  "resolver_id"
    t.datetime "resolved_at"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "estimates", ["relocation_id"], name: "index_estimates_on_relocation_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "stream_name"
    t.string   "stream_type"
    t.integer  "stream_id"
    t.text     "content"
    t.string   "event_type"
    t.integer  "initiator_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "events", ["organization_id", "stream_type", "stream_id", "stream_name"], name: "events_index", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id",                            null: false
    t.integer  "organization_id",                    null: false
    t.string   "role"
    t.boolean  "default",            default: false
    t.boolean  "can_access_legal",   default: false
    t.boolean  "can_access_finance", default: false
    t.boolean  "active",             default: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "memberships", ["organization_id"], name: "index_memberships_on_organization_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "old_passwords", force: :cascade do |t|
    t.string   "encrypted_password",       null: false
    t.string   "password_salt"
    t.string   "password_archivable_type", null: false
    t.integer  "password_archivable_id",   null: false
    t.datetime "created_at"
  end

  add_index "old_passwords", ["password_archivable_type", "password_archivable_id"], name: "index_password_archivable", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name",                        null: false
    t.string   "role",                        null: false
    t.boolean  "active",      default: false, null: false
    t.boolean  "internal",    default: false, null: false
    t.integer  "users_count", default: 0,     null: false
    t.integer  "access_id"
    t.string   "secret_key"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "organizations", ["access_id"], name: "index_organizations_on_access_id", using: :btree

  create_table "policies", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "name",                         null: false
    t.text     "description"
    t.string   "status",                       null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.text     "content"
    t.hstore   "versions",        default: [],              array: true
    t.hstore   "property_values"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "catalog_id"
  end

  add_index "policies", ["organization_id"], name: "index_policies_on_organization_id", using: :btree

  create_table "policy_benefits", force: :cascade do |t|
    t.integer  "service_type_id"
    t.string   "name",            null: false
    t.string   "description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "policy_id",       null: false
  end

  add_index "policy_benefits", ["policy_id"], name: "index_policy_benefits_on_policy_id", using: :btree
  add_index "policy_benefits", ["service_type_id"], name: "index_policy_benefits_on_service_type_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.integer  "organization_id",       null: false
    t.integer  "customer_id",           null: false
    t.string   "reference_number"
    t.string   "project_manager_name"
    t.string   "project_manager_email"
    t.string   "client_manager_name"
    t.string   "client_manager_email"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "projects", ["customer_id"], name: "index_projects_on_customer_id", using: :btree
  add_index "projects", ["organization_id"], name: "index_projects_on_organization_id", using: :btree

  create_table "properties", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "entity_type"
    t.string   "name"
    t.string   "value_type"
    t.string   "default_value"
    t.string   "choices",         default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "properties", ["entity_type"], name: "index_properties_on_entity_type", using: :btree
  add_index "properties", ["organization_id"], name: "index_properties_on_organization_id", using: :btree

  create_table "property_bundles", force: :cascade do |t|
    t.integer "organization_id"
    t.integer "property_id"
    t.integer "bundle_id"
  end

  add_index "property_bundles", ["bundle_id"], name: "index_property_bundles_on_bundle_id", using: :btree
  add_index "property_bundles", ["organization_id"], name: "index_property_bundles_on_organization_id", using: :btree
  add_index "property_bundles", ["property_id"], name: "index_property_bundles_on_property_id", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "parent_id",  null: false
    t.integer  "child_id",   null: false
    t.string   "role",       null: false
    t.string   "status",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "relationships", ["child_id"], name: "index_relationships_on_child_id", using: :btree
  add_index "relationships", ["parent_id"], name: "index_relationships_on_parent_id", using: :btree

  create_table "relocation_benefits", force: :cascade do |t|
    t.integer  "relocation_id"
    t.integer  "policy_benefit_id"
    t.string   "name",                              null: false
    t.integer  "budget_cents",      default: 0,     null: false
    t.string   "budget_currency",   default: "USD", null: false
    t.integer  "actual_cents",      default: 0,     null: false
    t.string   "actual_currency",   default: "USD", null: false
    t.string   "status"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "relocation_benefits", ["policy_benefit_id"], name: "index_relocation_benefits_on_policy_benefit_id", using: :btree
  add_index "relocation_benefits", ["relocation_id"], name: "index_relocation_benefits_on_relocation_id", using: :btree

  create_table "relocations", force: :cascade do |t|
    t.integer  "employee_id"
    t.integer  "organization_id"
    t.integer  "agency_id"
    t.integer  "policy_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "budget_cents",              default: 0,     null: false
    t.string   "budget_currency",           default: "USD", null: false
    t.string   "status"
    t.integer  "origin_metro_area_id"
    t.integer  "destination_metro_area_id"
    t.boolean  "onboarded",                 default: false
    t.integer  "initiator_id"
    t.hstore   "property_values"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "relocations", ["agency_id"], name: "index_relocations_on_agency_id", using: :btree
  add_index "relocations", ["destination_metro_area_id"], name: "index_relocations_on_destination_metro_area_id", using: :btree
  add_index "relocations", ["employee_id"], name: "index_relocations_on_employee_id", using: :btree
  add_index "relocations", ["organization_id"], name: "index_relocations_on_organization_id", using: :btree
  add_index "relocations", ["origin_metro_area_id"], name: "index_relocations_on_origin_metro_area_id", using: :btree
  add_index "relocations", ["policy_id"], name: "index_relocations_on_policy_id", using: :btree

  create_table "service_exceptions", force: :cascade do |t|
    t.integer  "relocation_services_id",                 null: false
    t.integer  "amount_cents",           default: 0,     null: false
    t.string   "amount_currency",        default: "USD", null: false
    t.text     "comments"
    t.string   "status"
    t.integer  "resolver_id"
    t.datetime "resolved_at"
    t.integer  "requester_id"
    t.datetime "requested_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "service_exceptions", ["relocation_services_id"], name: "index_service_exceptions_on_relocation_services_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.integer  "relocation_service_id", null: false
    t.integer  "organization_id_id"
    t.integer  "bundle_id"
    t.hstore   "property_values"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "services", ["bundle_id"], name: "index_services_on_bundle_id", using: :btree
  add_index "services", ["organization_id_id"], name: "index_services_on_organization_id_id", using: :btree
  add_index "services", ["property_values"], name: "index_services_on_property_values", using: :gin
  add_index "services", ["relocation_service_id"], name: "index_services_on_relocation_service_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                             default: "",    null: false
    t.string   "encrypted_password",                default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                   default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "first_name",                                        null: false
    t.string   "last_name",                                         null: false
    t.string   "user_name"
    t.boolean  "super_admin",                       default: false
    t.integer  "company_id",                                        null: false
    t.datetime "deleted_at"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.datetime "password_changed_at"
    t.string   "unique_session_id",      limit: 20
    t.datetime "last_activity_at"
    t.datetime "expired_at"
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["password_changed_at"], name: "index_users_on_password_changed_at", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
