class Exercise < ApplicationRecord
  has_many :exercise_entries

  validates :name, presence: true
end
