class AddRegististedAttendedColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :scout_events, :registered, :boolean, default: false
    add_column :scout_events, :attended, :boolean, default: false
    add_column :adult_events, :registered, :boolean, default: false
    add_column :adult_events, :attended, :boolean, default: false
  end
end
