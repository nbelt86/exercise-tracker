class Workout < ApplicationRecord
  belongs_to :user, optional: true
  has_many :exercise_entries, dependent: :destroy

  validates :name, presence: true
  validate :date_cannot_be_in_the_future

  private

  def date_cannot_be_in_the_future
    return if date.blank?

    errors.add(:date, "can't be in the future") if date > Date.today
  end
end
