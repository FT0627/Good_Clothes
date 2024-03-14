class Clothe < ApplicationRecord
  has_many_attached :clothes_images
  
  belongs_to :user
  belongs_to :category
  has_many :post_colors, dependent: :destroy
  has_many :colors. through: :post_color
end
