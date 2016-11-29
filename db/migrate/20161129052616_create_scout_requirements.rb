class CreateScoutRequirements < ActiveRecord::Migration[5.0]
  def change
    create_table :scout_requirements do |t|
      t.integer :scout_id
      t.integer :requirement_id
      t.string  :sign_off
      t.boolean :completed

      t.timestamps
    end
  end
end
