require "test_helper"

class WorkoutTest < ActiveSupport::TestCase
  def valid_attributes
    { user: users(:one), name: "Push Day", date: Date.today }
  end

  test "valid with valid attributes" do
    assert Workout.new(valid_attributes).valid?
  end

  test "invalid without a name" do
    workout = Workout.new(valid_attributes.merge(name: nil))
    assert_not workout.valid?
    assert_includes workout.errors[:name], "can't be blank"
  end

  test "valid with today's date" do
    assert Workout.new(valid_attributes.merge(date: Date.today)).valid?
  end

  test "invalid with a future date" do
    workout = Workout.new(valid_attributes.merge(date: Date.tomorrow))
    assert_not workout.valid?
    assert_includes workout.errors[:date], "can't be in the future"
  end

  test "valid without a date" do
    assert Workout.new(valid_attributes.merge(date: nil)).valid?
  end

  test "destroying a workout destroys its exercise entries" do
    workout = workouts(:one)
    entry = exercise_entries(:one)
    assert_equal workout, entry.workout

    assert_difference("ExerciseEntry.count", -1) do
      workout.destroy
    end
  end
end
