class CreateScouts < ActiveRecord::Migration[5.0]
  def change
    create_table :scouts do |t|
      t.string :name
      t.integer :grade
      t.date :birthdate
      t.references :patrol, foreign_key: true

      t.timestamps

      t.string   :name
      t.integer  :grade
      t.date     :birthdate
      t.integer  :patrol_id
      t.integer  :rank_id
      t.integer  :position_id
      t.timestamps
      t.index ["patrol_id"], name: "index_scouts_on_patrol_id"
      t.index ["rank_id"], name: "index_scouts_on_rank_id"
      t.index ["position_id"], name: "index_scouts_on_position_id"
    end
  end
end
