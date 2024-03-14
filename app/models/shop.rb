class Shop < ApplicationRecord
  
  has_one_attached :shop_image
  
  belongs_to :user
end
