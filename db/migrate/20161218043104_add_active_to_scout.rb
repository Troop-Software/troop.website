class AddActiveToScout < ActiveRecord::Migration[5.0]
  def change
    add_column :scouts, :active, :boolean, default: true
  end
end
