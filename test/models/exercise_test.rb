require "test_helper"

class ExerciseTest < ActiveSupport::TestCase
  test "has many exercise_entries" do
    exercise = exercises(:one)
    assert_includes exercise.exercise_entries, exercise_entries(:one)
  end
end
