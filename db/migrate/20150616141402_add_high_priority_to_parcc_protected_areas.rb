class AddHighPriorityToParccProtectedAreas < ActiveRecord::Migration
  def up
    add_column :parcc_protected_areas, :high_priority, :boolean, default: false
  end

  def down
    remove_column :parcc_protected_areas, :high_priority
  end
end
