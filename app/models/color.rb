class Color < ApplicationRecord
 has_many :post_colors, dependent: :destroy
 has_many :items, through: :post_colors

  validates :name, presence: true
end
