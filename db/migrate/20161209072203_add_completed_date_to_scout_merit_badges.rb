class AddCompletedDateToScoutMeritBadges < ActiveRecord::Migration[5.0]
  def change
        add_column :scout_merit_badges, :completed, :date
  end
end
