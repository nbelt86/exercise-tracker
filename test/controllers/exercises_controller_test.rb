require "test_helper"

class ExercisesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @exercise = exercises(:one)
    @other_exercise = exercises(:two)
  end

  test "redirects to sign in when not authenticated" do
    get exercises_path
    assert_redirected_to new_user_session_path
  end

  test "index lists exercises" do
    sign_in @user
    get exercises_path
    assert_response :success
    assert_match @exercise.name, response.body
  end

  test "show displays exercise details" do
    sign_in @user
    get exercise_path(@exercise)
    assert_response :success
    assert_match @exercise.name, response.body
  end

  test "index filters by name" do
    sign_in @user
    get exercises_path, params: { query: "bench" }
    assert_response :success
    assert_match @exercise.name, response.body
    assert_no_match @other_exercise.name, response.body
  end

  test "index filters by muscle group, case-insensitively" do
    sign_in @user
    get exercises_path, params: { query: "QUADS" }
    assert_response :success
    assert_match @other_exercise.name, response.body
    assert_no_match @exercise.name, response.body
  end

  test "index shows a no-matches message when the query has no results" do
    sign_in @user
    get exercises_path, params: { query: "nonexistent exercise xyz" }
    assert_response :success
    assert_match "No exercises match", response.body
  end
end
