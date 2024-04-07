class AddColumnsToShops < ActiveRecord::Migration[6.1]
  def change
    add_column :shops, :latitude, :float, null: false, default: 0
    add_column :shops, :longitude, :float, null: false, default: 0
  end
end
