require "test_helper"

class WorkoutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @workout = workouts(:one)
    @other_workout = workouts(:two)
    @user = users(:one)
  end

  test "redirects to sign in when not authenticated" do
    get workouts_path
    assert_redirected_to new_user_session_path
  end

  test "index lists only the current user's workouts" do
    sign_in @user
    get workouts_path
    assert_response :success
    assert_match @workout.name, response.body
  end

  test "show displays the current user's workout" do
    sign_in @user
    get workout_path(@workout)
    assert_response :success
  end

  test "show is not found for another user's workout" do
    sign_in @user
    get workout_path(@other_workout)
    assert_response :not_found
  end

  test "new renders the form" do
    sign_in @user
    get new_workout_path
    assert_response :success
  end

  test "create with valid attributes saves and redirects" do
    sign_in @user
    assert_difference("@user.workouts.count", 1) do
      post workouts_path, params: { workout: { name: "Leg Day", date: Date.today } }
    end
    assert_redirected_to workout_path(Workout.last)
  end

  test "create with invalid attributes does not save" do
    sign_in @user
    assert_no_difference("Workout.count") do
      post workouts_path, params: { workout: { name: "", date: Date.today } }
    end
    assert_response :unprocessable_entity
  end

  test "edit renders the form for the current user's workout" do
    sign_in @user
    get edit_workout_path(@workout)
    assert_response :success
  end

  test "edit is not found for another user's workout" do
    sign_in @user
    get edit_workout_path(@other_workout)
    assert_response :not_found
  end

  test "update with valid attributes saves and redirects" do
    sign_in @user
    patch workout_path(@workout), params: { workout: { name: "Updated Name" } }
    assert_redirected_to workout_path(@workout)
    assert_equal "Updated Name", @workout.reload.name
  end

  test "update with invalid attributes does not save" do
    sign_in @user
    patch workout_path(@workout), params: { workout: { name: "" } }
    assert_response :unprocessable_entity
    assert_not_equal "", @workout.reload.name
  end

  test "update cannot modify another user's workout" do
    sign_in @user
    patch workout_path(@other_workout), params: { workout: { name: "Hijacked" } }
    assert_response :not_found
    assert_not_equal "Hijacked", @other_workout.reload.name
  end

  test "destroy removes the current user's workout" do
    sign_in @user
    assert_difference("Workout.count", -1) do
      delete workout_path(@workout)
    end
    assert_redirected_to workouts_path
  end

  test "destroy cannot remove another user's workout" do
    sign_in @user
    assert_no_difference("Workout.count") do
      delete workout_path(@other_workout)
    end
    assert_response :not_found
  end
end
