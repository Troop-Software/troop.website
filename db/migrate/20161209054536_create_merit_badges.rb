class CreateMeritBadges < ActiveRecord::Migration[5.0]
  def change
    create_table :merit_badges do |t|
      t.string :name
      t.boolean :eagle_required
    end
  end
end
