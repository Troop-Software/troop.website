class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.datetime :start
      t.datetime :end
      t.boolean :allDay
      t.integer :category
      t.string :external_link

      t.timestamps
    end
  end
end
