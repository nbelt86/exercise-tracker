require "test_helper"

class ExerciseEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @workout = workouts(:one)
    @other_workout = workouts(:two)
    @entry = exercise_entries(:one)
    @other_entry = exercise_entries(:two)
  end

  test "create adds an exercise entry to the current user's workout" do
    sign_in @user
    assert_difference("@workout.exercise_entries.count", 1) do
      post workout_exercise_entries_path(@workout), params: { exercise_entry: { exercise_id: exercises(:two).id } }
    end
    assert_redirected_to workout_path(@workout)
  end

  test "create cannot add an exercise entry to another user's workout" do
    sign_in @user
    assert_no_difference("ExerciseEntry.count") do
      post workout_exercise_entries_path(@other_workout), params: { exercise_entry: { exercise_id: exercises(:one).id } }
    end
    assert_response :not_found
  end

  test "destroy removes an exercise entry from the current user's workout" do
    sign_in @user
    assert_difference("ExerciseEntry.count", -1) do
      delete workout_exercise_entry_path(@workout, @entry)
    end
    assert_redirected_to workout_path(@workout)
  end

  test "destroy cannot remove an exercise entry from another user's workout" do
    sign_in @user
    assert_no_difference("ExerciseEntry.count") do
      delete workout_exercise_entry_path(@other_workout, @other_entry)
    end
    assert_response :not_found
  end

  test "destroy cannot remove an exercise entry that belongs to a different workout" do
    sign_in @user
    assert_no_difference("ExerciseEntry.count") do
      delete workout_exercise_entry_path(@workout, @other_entry)
    end
    assert_response :not_found
  end
end
