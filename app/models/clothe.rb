class Clothe < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :shop
  has_many :post_colors, dependent: :destroy
  has_many :colors, through: :post_color

  has_many_attached :clothes_images
end
