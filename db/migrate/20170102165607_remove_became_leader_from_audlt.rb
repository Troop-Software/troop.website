class RemoveBecameLeaderFromAudlt < ActiveRecord::Migration[5.0]
  def change
    remove_column :adults, :became_leader
  end
end
