class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :items, through: :post_tags
end
