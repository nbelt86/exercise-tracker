class Workout < ApplicationRecord
  has_many :exercise_entries, dependent: :destroy
end
