class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :products, foreign_key: true
      t.string :products
    end
  end
end
