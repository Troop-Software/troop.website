class CreateAdultEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :adult_events do |t|
      t.references :adult, foreign_key: true
      t.references :event, foreign_key: true
      t.string :notes

      t.timestamps
    end
  end
end
