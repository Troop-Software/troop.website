class CreateScoutTrainings < ActiveRecord::Migration[5.0]
  def change
    create_table :scout_trainings do |t|
      t.references :scout, foreign_key: true
      t.references :youth_training, foreign_key: true
      t.date :completed_date

      t.timestamps
    end
  end
end
