class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.integer :prefecture, null: false, default: 0
      t.string :address, null: false
      t.text :discription, null: false
      t.timestamps
    end
  end
end
