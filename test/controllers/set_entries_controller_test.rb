require "test_helper"

class SetEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @workout = workouts(:one)
    @other_workout = workouts(:two)
    @entry = exercise_entries(:one)
    @other_entry = exercise_entries(:two)
    @set = set_entries(:one)
    @other_set = set_entries(:two)
  end

  test "create adds a set with an auto-incremented set_number" do
    sign_in @user
    assert_difference("@entry.set_entries.count", 1) do
      post workout_exercise_entry_set_entries_path(@workout, @entry), params: { set_entry: { reps: 8, weight: 100 } }
    end
    assert_equal 2, SetEntry.last.set_number
    assert_redirected_to workout_path(@workout)
  end

  test "create does not save a set with invalid attributes" do
    sign_in @user
    assert_no_difference("SetEntry.count") do
      post workout_exercise_entry_set_entries_path(@workout, @entry), params: { set_entry: { reps: 0, weight: 100 } }
    end
    assert_redirected_to workout_path(@workout)
  end

  test "create cannot add a set to another user's workout" do
    sign_in @user
    assert_no_difference("SetEntry.count") do
      post workout_exercise_entry_set_entries_path(@other_workout, @other_entry), params: { set_entry: { reps: 8, weight: 100 } }
    end
    assert_response :not_found
  end

  test "update modifies the current user's set" do
    sign_in @user
    patch workout_exercise_entry_set_entry_path(@workout, @entry, @set), params: { set_entry: { reps: 12, weight: 150 } }
    assert_redirected_to workout_path(@workout)
    @set.reload
    assert_equal 12, @set.reps
    assert_equal 150, @set.weight
  end

  test "update rejects invalid attributes" do
    sign_in @user
    patch workout_exercise_entry_set_entry_path(@workout, @entry, @set), params: { set_entry: { reps: -1 } }
    assert_redirected_to workout_path(@workout)
    assert_not_equal(-1, @set.reload.reps)
  end

  test "update cannot modify another user's set" do
    sign_in @user
    patch workout_exercise_entry_set_entry_path(@other_workout, @other_entry, @other_set), params: { set_entry: { reps: 12 } }
    assert_response :not_found
    assert_not_equal 12, @other_set.reload.reps
  end

  test "destroy removes the current user's set" do
    sign_in @user
    assert_difference("SetEntry.count", -1) do
      delete workout_exercise_entry_set_entry_path(@workout, @entry, @set)
    end
    assert_redirected_to workout_path(@workout)
  end

  test "destroy cannot remove another user's set" do
    sign_in @user
    assert_no_difference("SetEntry.count") do
      delete workout_exercise_entry_set_entry_path(@other_workout, @other_entry, @other_set)
    end
    assert_response :not_found
  end
end
