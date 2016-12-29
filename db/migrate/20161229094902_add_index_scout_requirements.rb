class AddIndexScoutRequirements < ActiveRecord::Migration[5.0]
  def change
    add_index :scout_requirements, [:requirement_id, :scout_id]
  end
end
