class CreateUser < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.references :user, foreign_key: true
      t.integer :user
    end
  end
end
