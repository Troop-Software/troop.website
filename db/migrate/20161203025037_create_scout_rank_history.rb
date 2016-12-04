class CreateScoutRankHistory < ActiveRecord::Migration[5.0]
  def change
    create_table :scout_rank_histories do |t|
      t.integer :scout_id
      t.integer :rank_id
      t.date :rank_completed

      t.timestamps
    end
  end
end
