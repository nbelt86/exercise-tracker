require "test_helper"

class SetEntryTest < ActiveSupport::TestCase
  def valid_attributes
    {
      exercise_entry: exercise_entries(:one),
      set_number: 1,
      reps: 10,
      weight: 135
    }
  end

  test "valid with valid attributes" do
    assert SetEntry.new(valid_attributes).valid?
  end

  test "valid with zero weight for bodyweight exercises" do
    assert SetEntry.new(valid_attributes.merge(weight: 0)).valid?
  end

  test "invalid without an exercise_entry" do
    set_entry = SetEntry.new(valid_attributes.merge(exercise_entry: nil))
    assert_not set_entry.valid?
    assert_includes set_entry.errors[:exercise_entry], "must exist"
  end

  test "invalid without a set_number" do
    set_entry = SetEntry.new(valid_attributes.merge(set_number: nil))
    assert_not set_entry.valid?
    assert_includes set_entry.errors[:set_number], "can't be blank"
  end

  test "invalid with a set_number that is not positive" do
    set_entry = SetEntry.new(valid_attributes.merge(set_number: 0))
    assert_not set_entry.valid?
    assert_includes set_entry.errors[:set_number], "must be greater than 0"
  end

  test "invalid without reps" do
    set_entry = SetEntry.new(valid_attributes.merge(reps: nil))
    assert_not set_entry.valid?
    assert_includes set_entry.errors[:reps], "can't be blank"
  end

  test "invalid with reps that are not positive" do
    set_entry = SetEntry.new(valid_attributes.merge(reps: 0))
    assert_not set_entry.valid?
    assert_includes set_entry.errors[:reps], "must be greater than 0"
  end

  test "invalid without weight" do
    set_entry = SetEntry.new(valid_attributes.merge(weight: nil))
    assert_not set_entry.valid?
    assert_includes set_entry.errors[:weight], "can't be blank"
  end

  test "invalid with negative weight" do
    set_entry = SetEntry.new(valid_attributes.merge(weight: -5))
    assert_not set_entry.valid?
    assert_includes set_entry.errors[:weight], "must be greater than or equal to 0"
  end
end
