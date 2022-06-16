class CreateAddUserId < ActiveRecord::Migration[5.2]
  def change
    create_table :add_user_ids do |t|
      t.references :user, foreign_key: true
      t.integer :user
    end
  end
end
