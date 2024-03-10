class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      t.string :name, null: false
      t.string :prefecture, null: false
      t.string :address, null: false
      t.text :discription, null: false
      t.timestamps
    end
  end
end
