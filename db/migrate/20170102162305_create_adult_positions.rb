class CreateAdultPositions < ActiveRecord::Migration[5.0]
  def change
    create_table :adult_positions do |t|
      t.references :adult, foreign_key: true
      t.references :position, foreign_key: true
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
