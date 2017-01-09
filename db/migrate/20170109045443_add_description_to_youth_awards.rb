class AddDescriptionToYouthAwards < ActiveRecord::Migration[5.0]
  def change
    add_column :youth_awards, :description, :string
  end
end
