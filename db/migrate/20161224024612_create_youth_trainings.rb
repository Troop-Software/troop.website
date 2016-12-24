class CreateYouthTrainings < ActiveRecord::Migration[5.0]
  def change
    create_table :youth_trainings do |t|
      t.string :name
      t.string :abbr
      t.string :bsa_code
      t.string :description
      t.string :url

      t.timestamps
    end
  end
end
