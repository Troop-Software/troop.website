class AddMbToRequirements < ActiveRecord::Migration[5.0]
  def change
    add_column :requirements, :mb, :boolean
  end
end
