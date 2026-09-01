require "test_helper"

class ExerciseEntryTest < ActiveSupport::TestCase
  test "invalid without an exercise" do
    entry = ExerciseEntry.new(workout: workouts(:one))
    assert_not entry.valid?
    assert_includes entry.errors[:exercise], "must exist"
  end

  test "invalid without a workout" do
    entry = ExerciseEntry.new(exercise: exercises(:one))
    assert_not entry.valid?
    assert_includes entry.errors[:workout], "must exist"
  end

  test "destroying an exercise entry destroys its set entries" do
    entry = exercise_entries(:one)
    assert_includes entry.set_entries, set_entries(:one)

    assert_difference("SetEntry.count", -1) do
      entry.destroy
    end
  end

  test "previous_entry returns the most recent earlier entry for the same exercise" do
    user = users(:one)
    exercise = Exercise.create!(name: "Isolated Progression Exercise")

    oldest_workout = user.workouts.create!(name: "Oldest", date: 10.days.ago.to_date)
    older_workout = user.workouts.create!(name: "Older", date: 5.days.ago.to_date)
    newest_workout = user.workouts.create!(name: "Newest", date: 1.day.ago.to_date)

    oldest_entry = oldest_workout.exercise_entries.create!(exercise: exercise)
    older_entry = older_workout.exercise_entries.create!(exercise: exercise)
    newest_entry = newest_workout.exercise_entries.create!(exercise: exercise)

    assert_equal older_entry, newest_entry.previous_entry
    assert_equal oldest_entry, older_entry.previous_entry
    assert_nil oldest_entry.previous_entry
  end

  test "previous_entry ignores entries for a different exercise" do
    user = users(:one)
    logged_exercise = Exercise.create!(name: "Isolated Exercise")
    unrelated_exercise = Exercise.create!(name: "Unrelated Exercise")

    older_workout = user.workouts.create!(name: "Older", date: 5.days.ago.to_date)
    newer_workout = user.workouts.create!(name: "Newer", date: 1.day.ago.to_date)

    older_workout.exercise_entries.create!(exercise: unrelated_exercise)
    newer_entry = newer_workout.exercise_entries.create!(exercise: logged_exercise)

    assert_nil newer_entry.previous_entry
  end

  test "previous_entry is nil when the workout has no date" do
    user = users(:one)
    exercise = Exercise.create!(name: "Undated Workout Exercise")
    workout = user.workouts.create!(name: "Undated", date: nil)
    entry = workout.exercise_entries.create!(exercise: exercise)

    assert_nil entry.previous_entry
  end
end
