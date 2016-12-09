class AddBorFlagToRequirements < ActiveRecord::Migration[5.0]
  def change
        add_column :requirements, :bor, :boolean
  end
end
