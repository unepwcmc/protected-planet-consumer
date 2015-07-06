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

ActiveRecord::Schema.define(version: 20150630134510) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gef_areas", force: true do |t|
    t.integer  "gef_pmis_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gef_biomes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gef_budget_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gef_column_matches", force: true do |t|
    t.string   "model_columns"
    t.text     "xls_columns"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gef_countries", force: true do |t|
    t.integer  "gef_region_id"
    t.string   "name"
    t.string   "iso_3"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gef_country_wdpa_records", force: true do |t|
    t.integer  "gef_wdpa_record_id"
    t.integer  "gef_country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gef_pame_names", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gef_pame_record_wdpa_records", force: true do |t|
    t.integer  "gef_pame_record_id"
    t.integer  "gef_wdpa_record_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gef_pame_records", force: true do |t|
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
    t.integer  "gef_wdpa_record_id"
    t.string   "primary_biome_area"
    t.string   "secondary_biome_area"
    t.string   "tertiary_biome_area"
    t.string   "quaternary_biome_area"
    t.integer  "gef_area_id"
    t.integer  "gef_pame_name_id"
    t.integer  "budget_recurrent_type_id"
    t.float    "budget_recurrent_value"
    t.integer  "budget_project_type_id"
    t.float    "budget_project_value"
    t.integer  "primary_biome_id"
    t.integer  "secondary_biome_id"
    t.integer  "tertiary_biome_id"
    t.integer  "quaternary_biome_id"
  end

  create_table "gef_regions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gef_searches", force: true do |t|
    t.integer  "gef_country_id"
    t.integer  "gef_region_id"
    t.integer  "gef_pmis_id"
    t.integer  "wdpa_id"
    t.string   "wdpa_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "primary_biome_id"
  end

  create_table "gef_wdpa_records", force: true do |t|
    t.integer  "wdpa_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "gef_area_id"
    t.integer  "gef_pame_name_id"
    t.string   "wdpa_name"
    t.string   "original_name"
    t.boolean  "marine"
    t.decimal  "reported_area"
    t.string   "sub_location"
    t.string   "iucn_category"
    t.string   "designation"
    t.string   "jurisdiction"
    t.string   "legal_status"
    t.string   "governance"
    t.boolean  "wdpa_exists"
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
    t.integer  "count_total_species"
    t.integer  "count_vulnerable_species"
    t.integer  "percentage_vulnerable_species"
    t.boolean  "high_priority",                 default: false
  end

  add_index "parcc_protected_areas", ["wdpa_id"], name: "index_parcc_protected_areas_on_wdpa_id", using: :btree

  create_table "parcc_species", force: true do |t|
    t.integer  "parcc_taxonomic_order_id"
    t.string   "name"
    t.string   "iucn_cat"
    t.string   "sensitivity"
    t.string   "adaptability"
    t.string   "exposure_2025"
    t.string   "exposure_2055"
    t.boolean  "cc_vulnerable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parcc_species_protected_areas", force: true do |t|
    t.integer  "parcc_species_id"
    t.integer  "parcc_protected_area_id"
    t.float    "intersection_area"
    t.float    "overlap_percentage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "parcc_species_protected_areas", ["parcc_protected_area_id"], name: "index_parcc_species_protected_areas_on_parcc_protected_area_id", using: :btree

  create_table "parcc_species_turnovers", force: true do |t|
    t.integer  "parcc_protected_area_id"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "taxonomic_class_id"
    t.float    "lower"
    t.float    "median"
    t.float    "upper"
  end

  add_index "parcc_species_turnovers", ["parcc_protected_area_id"], name: "index_parcc_species_turnovers_on_parcc_protected_area_id", using: :btree

  create_table "parcc_suitability_changes", force: true do |t|
    t.integer  "parcc_species_id"
    t.integer  "parcc_protected_area_id"
    t.integer  "year"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "parcc_suitability_changes", ["parcc_protected_area_id"], name: "index_parcc_suitability_changes_on_parcc_protected_area_id", using: :btree
  add_index "parcc_suitability_changes", ["parcc_species_id"], name: "index_parcc_suitability_changes_on_parcc_species_id", using: :btree
  add_index "parcc_suitability_changes", ["value"], name: "index_parcc_suitability_changes_on_value", where: "(((value)::text = 'Dec'::text) OR ((value)::text = 'Inc'::text))", using: :btree

  create_table "parcc_taxonomic_classes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parcc_taxonomic_orders", force: true do |t|
    t.integer  "parcc_taxonomic_class_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
