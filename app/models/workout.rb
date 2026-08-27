class Workout < ApplicationRecord
  has_many :exercise_entries, dependent: :destroy

  validates :name, presence: true
end
