class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :file
      t.string :type
      t.string :original_name

      t.timestamps
    end
  end
end
