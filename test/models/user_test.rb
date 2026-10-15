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

  test "regular users are not guests by default" do
    assert_not users(:one).guest?
  end

  test "create_guest! creates a persisted, flagged guest user" do
    guest = nil
    assert_difference("User.count", 1) do
      guest = User.create_guest!
    end
    assert guest.persisted?
    assert guest.guest?
  end

  test "create_guest! seeds the guest with a sample workout" do
    guest = User.create_guest!
    assert guest.workouts.exists?
    assert guest.workouts.first.exercise_entries.exists?
  end
end
