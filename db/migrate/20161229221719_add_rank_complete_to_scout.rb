class AddRankCompleteToScout < ActiveRecord::Migration[5.0]
  def change
    add_column :scouts, :rank_completion, :decimal
  end
end
