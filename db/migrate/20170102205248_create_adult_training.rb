class CreateAdultTraining < ActiveRecord::Migration[5.0]
  def change
    create_table :adult_trainings do |t|
      t.string :name
      t.string :bsa_code
      t.date :expired

      t.timestamps
    end
  end
end
