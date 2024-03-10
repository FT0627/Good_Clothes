class CreateClothes < ActiveRecord::Migration[6.1]
  def change
    create_table :clothes do |t|
      t.integer :user_id, null: false
      t.integer :shop_id, null: false
      t.integer :color_id, null: false
      t.string :star, null: false
      t.timestamps
    end
  end
end
