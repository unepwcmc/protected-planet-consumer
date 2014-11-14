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

ActiveRecord::Schema.define(version: 20141111175448) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gef_areas", force: true do |t|
    t.integer  "gef_pmis_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gef_column_matches", force: true do |t|
    t.string   "model_columns"
    t.text     "xls_columns"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gef_wdpa_records", force: true do |t|
    t.integer  "wdpa_id"
    t.text     "pa_name_mett"
    t.integer  "mett_original_uid"
    t.string   "mett_new_uid"
    t.text     "assessment_type"
    t.text     "assessment_year"
    t.text     "legal_status"
    t.integer  "pa_regulations"
    t.integer  "law_enforcement"
    t.integer  "pa_objectives"
    t.integer  "pa_design"
    t.integer  "pa_boundary_demarcation"
    t.integer  "management_plan"
    t.integer  "regular_work_plan"
    t.integer  "resource_inventory"
    t.integer  "protection_systems"
    t.integer  "research"
    t.integer  "resource_management"
    t.integer  "staff_numbers"
    t.integer  "staff_training"
    t.integer  "current_budget"
    t.integer  "security_of_budget"
    t.integer  "management_of_budget"
    t.integer  "equipment"
    t.integer  "maintenance_of_equipment"
    t.integer  "education_and_awareness"
    t.integer  "planning_for_land_and_water"
    t.integer  "stage_and_commercial_neighbours"
    t.integer  "indigenous_people"
    t.integer  "local_communities"
    t.integer  "weconomic_benefit"
    t.integer  "monitoring_and_evaluation"
    t.integer  "visitor_facilities"
    t.integer  "commercial_tourism_operators"
    t.integer  "fees"
    t.integer  "condition_of_values"
    t.integer  "personal_management"
    t.integer  "access_assessment"
    t.integer  "total_mett_score"
    t.integer  "total_possible_score"
    t.integer  "overall_percentage"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "gef_area_id"
  end

  create_table "parcc_protected_areas", force: true do |t|
    t.integer  "parcc_id"
    t.string   "name"
    t.string   "iso_3"
    t.integer  "poly_id"
    t.string   "designation"
    t.string   "geom_type"
    t.string   "iucn_cat"
    t.integer  "wdpa_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parcc_species_turnovers", force: true do |t|
    t.integer  "parcc_protected_area_id"
    t.string   "taxonomic_class"
    t.integer  "year"
    t.string   "stat"
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
