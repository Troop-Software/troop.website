class AddShortDescToRequirements < ActiveRecord::Migration[5.0]
  def change
    add_column :requirements, :short_desc, :text
  end
end
