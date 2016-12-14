class CreateRelationship < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.references :scout, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
