class CreateNotification < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.string :text
      t.string :link
      t.boolean :active, default: true
    end
  end
end
