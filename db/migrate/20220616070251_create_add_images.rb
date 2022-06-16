class CreateAddImages < ActiveRecord::Migration[5.2]
  def change
    create_table :add_images do |t|
      t.references :images, foreign_key: true
      t.string :images
    end
  end
end
