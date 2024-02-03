class Post < ApplicationRecord
  belongs_to :user
  validates :name, :content, :user_id, presence: { message: 'obligatoire' }
  validates :image_file, presence: true, on: :create

  has_image :image
end
