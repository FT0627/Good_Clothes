class Category < ApplicationRecord
  has_many :clothes
  
  validates :name, presence: true
end
