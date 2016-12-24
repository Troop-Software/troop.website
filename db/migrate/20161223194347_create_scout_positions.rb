class CreateScoutPositions < ActiveRecord::Migration[5.0]
  def change
    create_table :scout_positions do |t|
      t.references :scout, foreign_key: true
      t.references :position, foreign_key: true
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
