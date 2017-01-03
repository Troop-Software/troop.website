class AddInactiveToAdults < ActiveRecord::Migration[5.0]
  def change
    add_column :adults, :inactive, :boolean, default: false
  end
end
