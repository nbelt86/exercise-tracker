class ExerciseEntry < ApplicationRecord
  belongs_to :exercise
  belongs_to :workout
  has_many :set_entries, dependent: :destroy

  def previous_entry
    ExerciseEntry.joins(:workout)
                 .where(exercise_id: exercise_id)
                 .where.not(id: id)
                 .where.not(workout_id: workout_id)
                 .order("workouts.date DESC, workouts.id DESC")
                 .first
  end
end
