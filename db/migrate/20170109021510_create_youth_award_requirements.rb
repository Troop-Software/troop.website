class CreateYouthAwardRequirements < ActiveRecord::Migration[5.0]
  def change
    create_table :youth_award_requirements do |t|
      t.references :youth_award, foreign_key: true
      t.integer :req_num
      t.string :description
    end
  end
end
