class CreateAdultTrainings < ActiveRecord::Migration[5.0]
  def change
    create_table :adult_trainings do |t|
      t.references :adult, foreign_key: true
      t.references :adult_training_course, foreign_key: true
      t.date :completed_date

      t.timestamps
    end
  end
end
