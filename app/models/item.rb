class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :shop

  has_many :post_comments

  has_many :post_colors, dependent: :destroy
  has_many :colors, through: :post_colors

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  has_many_attached :item_images

  validates :shop_id, presence: true
  validates :category_id, presence: true
  validates :item_images, presence: true
  validates :colors, presence: true
  

end
