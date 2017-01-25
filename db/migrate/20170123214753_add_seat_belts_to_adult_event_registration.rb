class AddSeatBeltsToAdultEventRegistration < ActiveRecord::Migration[5.0]
  def change
    add_column :adult_events, :seatbelts, :integer
  end
end
