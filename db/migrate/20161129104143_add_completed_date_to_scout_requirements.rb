class AddCompletedDateToScoutRequirements < ActiveRecord::Migration[5.0]
  def change
    add_column :scout_requirements, :completed_date, :date
  end
end
