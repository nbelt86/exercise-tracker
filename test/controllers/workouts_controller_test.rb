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

  test "index counts only this user's workouts logged this week" do
    sign_in @user
    @user.workouts.create!(name: "Monday", date: Date.today.beginning_of_week)
    @user.workouts.create!(name: "Today", date: Date.today)
    @user.workouts.create!(name: "Last week", date: 8.days.ago.to_date)
    users(:two).workouts.create!(name: "Other user's", date: Date.today)

    get workouts_path
    assert_response :success
    assert_select "span.text-2xl", text: "2"
  end

  test "index computes the current streak of consecutive days" do
    sign_in @user
    @user.workouts.create!(name: "Today", date: Date.today)
    @user.workouts.create!(name: "Yesterday", date: 1.day.ago.to_date)
    @user.workouts.create!(name: "Two days ago", date: 2.days.ago.to_date)
    @user.workouts.create!(name: "Not consecutive", date: 10.days.ago.to_date)

    get workouts_path
    assert_response :success
    assert_select "span", text: "3"
  end

  test "index streak counts yesterday even if nothing logged today yet" do
    sign_in @user
    @user.workouts.create!(name: "Yesterday", date: 1.day.ago.to_date)

    get workouts_path
    assert_response :success
    assert_select "span", text: "1"
  end

  test "index sums this week's volume across this user's sets only" do
    sign_in @user
    workout = @user.workouts.create!(name: "This week", date: Date.today)
    entry = workout.exercise_entries.create!(exercise: exercises(:one))
    entry.set_entries.create!(set_number: 1, reps: 10, weight: 100)
    entry.set_entries.create!(set_number: 2, reps: 5, weight: 50)

    other_workout = users(:two).workouts.create!(name: "Other user's", date: Date.today)
    other_entry = other_workout.exercise_entries.create!(exercise: exercises(:two))
    other_entry.set_entries.create!(set_number: 1, reps: 100, weight: 100)

    get workouts_path
    assert_response :success
    assert_match "1,250", response.body
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

  test "duplicate copies the workout's name, today's date, and its exercises" do
    sign_in @user
    entry = exercise_entries(:one)

    assert_difference("Workout.count", 1) do
      post duplicate_workout_path(@workout)
    end

    new_workout = Workout.last
    assert_redirected_to workout_path(new_workout)
    assert_equal @workout.name, new_workout.name
    assert_equal Date.today, new_workout.date
    assert_equal [entry.exercise_id], new_workout.exercise_entries.pluck(:exercise_id)
  end

  test "duplicate does not copy set entries" do
    sign_in @user
    set_entries(:one)

    post duplicate_workout_path(@workout)

    new_workout = Workout.last
    assert new_workout.exercise_entries.first.set_entries.empty?
  end

  test "duplicate cannot be performed on another user's workout" do
    sign_in @user
    assert_no_difference("Workout.count") do
      post duplicate_workout_path(@other_workout)
    end
    assert_response :not_found
  end
end
