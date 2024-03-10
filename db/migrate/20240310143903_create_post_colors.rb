class CreatePostColors < ActiveRecord::Migration[6.1]
  def change
    create_table :post_colors do |t|
      t.integer :clothes_id, null: false
      t.integer :color, null: false
      t.timestamps
    end
  end
end
