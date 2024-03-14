class Color < ApplicationRecord
 has_many :post_colors, dependent: :destroy
 has_many :colors, through: :post_color
  
  validates :name, presence: true
end
