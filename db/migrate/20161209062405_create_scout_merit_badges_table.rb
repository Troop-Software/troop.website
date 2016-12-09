class CreateScoutMeritBadgesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :scout_merit_badges do |t|
       t.integer  "scout_id"
       t.integer  "merit_badge_id"
       
       t.timestamps
    end
  end
end
