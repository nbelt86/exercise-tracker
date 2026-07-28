class ExerciseEntry < ApplicationRecord
  belongs_to :exercise
  belongs_to :workout
  has_many :set_entries, dependent: :destroy
end
