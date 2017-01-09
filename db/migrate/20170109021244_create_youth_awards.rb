class CreateYouthAwards < ActiveRecord::Migration[5.0]
  def change
    create_table :youth_awards do |t|
      t.string :name
      t.boolean :multiple, default: false
      t.boolean :active, default: true
    end
  end
end
