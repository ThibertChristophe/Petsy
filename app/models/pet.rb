class Pet < ApplicationRecord
  belongs_to :user
  belongs_to :species

  validates :name, :gender, :birthday, presence: { message: 'obligatoire' }
  validates :gender, format: { with: /\A(M|F)\z/ }
  validate :birthday_not_future

  def birthday_not_future
    return unless birthday.present? && birthday.future?

    errors.add :birthday, 'ne peut être dans le futur'
  end

  def age
    Time.now.year - birthday.year
  end
end
