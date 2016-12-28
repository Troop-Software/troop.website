class AddShortNameToMb < ActiveRecord::Migration[5.0]
  def change
    add_column :merit_badges, :short_name, :string
  end
end
