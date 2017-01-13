class AddLastRegistrationDateToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :last_registration_date, :date
  end
end
