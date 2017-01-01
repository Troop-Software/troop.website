class CreateAdultPositions < ActiveRecord::Migration[5.0]
  def change
    create_table :adult_positions do |t|
      t.string :name
      t.string :code
      t.string :abbr
    end
  end
end
