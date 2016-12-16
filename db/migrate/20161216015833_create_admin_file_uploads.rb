class CreateAdminFileUploads < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_file_uploads do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
