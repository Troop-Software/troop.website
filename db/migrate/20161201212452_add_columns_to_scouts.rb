class AddColumnsToScouts < ActiveRecord::Migration[5.0]
  def change
    add_column :scouts, :email, :string
    add_column :scouts, :phone, :string
    add_column :scouts, :joined, :date
    add_column :scouts, :bsa_id, :integer
  end
end
