class CreateAdults < ActiveRecord::Migration[5.0]
  def change
    create_table :adults do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.integer :sex
      t.string :email
      t.string :phone
      t.integer :bsa_id
      t.date :dob
      t.string :drivers_license
      t.date :joined
      t.date :became_leader

      #t.references :adult_position, foreign_key: true
    end
  end
end
