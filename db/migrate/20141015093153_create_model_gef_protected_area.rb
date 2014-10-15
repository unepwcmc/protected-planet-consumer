class CreateModelGefProtectedArea < ActiveRecord::Migration
  def change
    create_table :model_gef_protected_areas do |t|
      t.string :gef_pims_id
      t.integer :wdpa_id
      t.text :pa_name_mett
      t.integer :mett_original_uid
      t.string :mett_new_uid
      t.text :assessment_type
      t.text :assessment_year
      t.text :legal_status
      t.integer :pa_regulations
      t.integer :law_enforcement
      t.integer :pa_objectives
      t.integer :pa_design
      t.integer :pa_boundary_demarcation
      t.integer :management_plan
      t.integer :regular_work_plan
      t.integer :resource_inventory
      t.integer :protection_systems
      t.integer :research
      t.integer :resource_management
      t.integer :staff_numbers
      t.integer :staff_training
      t.integer :current_budget
      t.integer :security_of_budget
      t.integer :management_of_budget
      t.integer :equipment
      t.integer :maintenance_of_equipment
      t.integer :education_and_awareness
      t.integer :planning_for_land_and_water
      t.integer :stage_and_commercial_neighbours
      t.integer :indigenous_people
      t.integer :local_communities
      t.integer :weconomic_benefit
      t.integer :monitoring_and_evaluation
      t.integer :visitor_facilities
      t.integer :commercial_tourism_operators
      t.integer :fees
      t.integer :condition_of_values
      t.integer :personal_management
      t.integer :access_assessment
      t.integer :total_mett_score
      t.integer :total_possible_score
      t.integer :overall_percentage
    end
  end
end
