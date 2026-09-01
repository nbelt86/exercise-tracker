require "test_helper"

class UserTest < ActiveSupport::TestCase
  def valid_attributes
    { email: "new@example.com", password: "password", password_confirmation: "password" }
  end

  test "valid with valid attributes" do
    assert User.new(valid_attributes).valid?
  end

  test "invalid without an email" do
    user = User.new(valid_attributes.merge(email: nil))
    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test "invalid with a duplicate email" do
    user = User.new(valid_attributes.merge(email: users(:one).email))
    assert_not user.valid?
    assert_includes user.errors[:email], "has already been taken"
  end

  test "destroying a user destroys their workouts" do
    user = users(:one)
    workout = workouts(:one)
    assert_equal user, workout.user

    assert_difference("Workout.count", -1) do
      user.destroy
    end
  end
end
