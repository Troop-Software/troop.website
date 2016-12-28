class AddLoggingToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :logged_units, :decimal
  end
end
