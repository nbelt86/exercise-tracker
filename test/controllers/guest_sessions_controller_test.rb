require "test_helper"

class GuestSessionsControllerTest < ActionDispatch::IntegrationTest
  test "creates a guest user, signs them in, and redirects to workouts with demo data" do
    assert_difference("User.count", 1) do
      post guest_sign_in_path
    end

    assert_redirected_to workouts_path
    follow_redirect!
    assert_response :success
    assert_match "Push Day", response.body
  end
end
