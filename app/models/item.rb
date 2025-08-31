class Item < ApplicationRecord
  validates :image, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates

  belongs_to :user

  has_one_attached :image
end
