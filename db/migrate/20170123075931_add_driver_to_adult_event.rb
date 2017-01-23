class AddDriverToAdultEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :adult_events, :driver, :boolean, default: false
  end
end
