class CreateScoutEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :scout_events do |t|
      t.integer :scout_id
      t.integer :event_id
      t.string :notes

      t.timestamps
    end
  end
end
