class RemoveColumnsFromWdpaRecord < ActiveRecord::Migration
  def change
      remove_column :gef_wdpa_records, :pa_name_mett
      remove_column :gef_wdpa_records, :mett_original_uid
      remove_column :gef_wdpa_records, :mett_new_uid
      remove_column :gef_wdpa_records, :assessment_type
      remove_column :gef_wdpa_records, :assessment_year
      remove_column :gef_wdpa_records, :legal_status
      remove_column :gef_wdpa_records, :pa_regulations
      remove_column :gef_wdpa_records, :law_enforcement
      remove_column :gef_wdpa_records, :pa_objectives
      remove_column :gef_wdpa_records, :pa_design
      remove_column :gef_wdpa_records, :pa_boundary_demarcation
      remove_column :gef_wdpa_records, :management_plan
      remove_column :gef_wdpa_records, :regular_work_plan
      remove_column :gef_wdpa_records, :resource_inventory
      remove_column :gef_wdpa_records, :protection_systems
      remove_column :gef_wdpa_records, :research
      remove_column :gef_wdpa_records, :resource_management
      remove_column :gef_wdpa_records, :staff_numbers
      remove_column :gef_wdpa_records, :staff_training
      remove_column :gef_wdpa_records, :current_budget
      remove_column :gef_wdpa_records, :security_of_budget
      remove_column :gef_wdpa_records, :management_of_budget
      remove_column :gef_wdpa_records, :equipment
      remove_column :gef_wdpa_records, :maintenance_of_equipment
      remove_column :gef_wdpa_records, :education_and_awareness
      remove_column :gef_wdpa_records, :planning_for_land_and_water
      remove_column :gef_wdpa_records, :stage_and_commercial_neighbours
      remove_column :gef_wdpa_records, :indigenous_people
      remove_column :gef_wdpa_records, :local_communities
      remove_column :gef_wdpa_records, :weconomic_benefit
      remove_column :gef_wdpa_records, :monitoring_and_evaluation
      remove_column :gef_wdpa_records, :visitor_facilities
      remove_column :gef_wdpa_records, :commercial_tourism_operators
      remove_column :gef_wdpa_records, :fees
      remove_column :gef_wdpa_records, :condition_of_values
      remove_column :gef_wdpa_records, :personal_management
      remove_column :gef_wdpa_records, :access_assessment
      remove_column :gef_wdpa_records, :total_mett_score
      remove_column :gef_wdpa_records, :total_possible_score
      remove_column :gef_wdpa_records, :overall_percentage

  end
end
