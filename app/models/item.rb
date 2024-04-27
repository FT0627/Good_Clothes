class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :shop

  has_many :post_comments, dependent: :destroy

  has_many :post_colors, dependent: :destroy
  has_many :colors, through: :post_colors

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy

  has_many_attached :item_images

  validates :shop_id, presence: true
  validates :category_id, presence: true
  validates :item_images, presence: true
  validates :color_ids, presence: true
  validates :star, presence: true

  def save_tags(tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      tag = Tag.find_or_create_by(name: new_name)
      self.tags << tag
    end
  end


end
