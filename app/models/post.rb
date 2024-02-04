class Post < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :pets

  validates :name, :pet_ids, :content, :user_id, presence: { message: 'obligatoire' }
  validates :image_file, presence: true, on: :create

  has_image :image
end
