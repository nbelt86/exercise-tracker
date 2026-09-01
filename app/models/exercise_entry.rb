class ExerciseEntry < ApplicationRecord
  belongs_to :exercise
  belongs_to :workout
  has_many :set_entries, dependent: :destroy

  def previous_entry
    return nil if workout.date.nil?

    ExerciseEntry.joins(:workout)
                 .where(exercise_id: exercise_id)
                 .where.not(id: id)
                 .where.not(workouts: { date: nil })
                 .where("workouts.date < :date OR (workouts.date = :date AND workouts.id < :workout_id)",
                        date: workout.date, workout_id: workout_id)
                 .order("workouts.date DESC, workouts.id DESC")
                 .first
  end
end
