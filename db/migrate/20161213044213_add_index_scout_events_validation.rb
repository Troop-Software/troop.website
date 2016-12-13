class AddIndexScoutEventsValidation < ActiveRecord::Migration[5.0]
  def change
    add_index :scout_events, [:scout_id, :event_id], unique: true
  end
end
