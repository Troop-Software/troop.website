class RemoveCompletedFromScoutRequirements < ActiveRecord::Migration[5.0]
  def change
    remove_column :scout_requirements, :completed
  end
end
