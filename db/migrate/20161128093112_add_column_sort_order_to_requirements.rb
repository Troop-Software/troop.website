class AddColumnSortOrderToRequirements < ActiveRecord::Migration[5.0]
  def change
    add_column :requirements, :sortOrder, :integer
  end
end
