class Pet < ApplicationRecord
  belongs_to :user
  belongs_to :species
  has_and_belongs_to_many :posts

  validates :name, :gender, :birthday, presence: { message: 'obligatoire' }
  validates :gender, format: { with: /\A(M|F)\z/ }
  validate :birthday_not_future
  validates :avatar_file, presence: true, on: :create

  has_image :avatar

  after_destroy :destroy_posts

  def birthday_not_future
    return unless birthday.present? && birthday.future?

    errors.add :birthday, 'ne peut être dans le futur'
  end

  def age
    Time.now.year - birthday.year
  end

  private

  # pour destroy les posts
  def destroy_posts
    Post.find_by_sql('SELECT * FORM posts LEFT JOIN pets_posts ON pets_posts.post_id = post.id WHERE pets_posts.post_id IS NULL').each do |post|
      post.destroy
    end
  end
end
