class Clothe < ApplicationRecord
  has_many_attached :clothes_images
  
  belongs_to :user
  belongs_to :category
end
