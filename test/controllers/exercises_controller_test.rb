require "test_helper"

class ExercisesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @exercise = exercises(:one)
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
end
