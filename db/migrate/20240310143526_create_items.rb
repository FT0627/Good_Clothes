class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :user_id, null: false
      t.integer :shop_id, null: false
      t.integer :category_id, null: false
      t.timestamps
    end
  end
end
