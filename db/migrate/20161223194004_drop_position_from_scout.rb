class DropPositionFromScout < ActiveRecord::Migration[5.0]
  def change
    remove_column :scouts, :position_id
  end

end
