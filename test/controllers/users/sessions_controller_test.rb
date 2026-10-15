require "test_helper"

class Users::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "signing out a guest destroys their account" do
    post guest_sign_in_path
    guest = User.last
    assert guest.guest?

    assert_difference("User.count", -1) do
      delete destroy_user_session_path
    end
    assert_not User.exists?(guest.id)
  end

  test "signing out a regular user does not destroy their account" do
    user = users(:one)
    sign_in user

    assert_no_difference("User.count") do
      delete destroy_user_session_path
    end
    assert User.exists?(user.id)
  end
end
