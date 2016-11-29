class CreateRequirements < ActiveRecord::Migration[5.0]
  def change
    create_table :requirements do |t|
      t.integer :revision
      t.integer :rank_id
      t.integer :req_category
      t.string  :req_num
      t.string  :description

      t.timestamps
    end
  end
end
