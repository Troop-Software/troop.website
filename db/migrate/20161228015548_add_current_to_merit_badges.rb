class AddCurrentToMeritBadges < ActiveRecord::Migration[5.0]
  def change
    add_column :merit_badges, :current, :boolean, default: true
  end
end
