class SetEntriesController < ApplicationController
  before_action :set_workout

  def create
    @exercise_entry = @workout.exercise_entries.find(params[:exercise_entry_id])
    @set_entry = @exercise_entry.set_entries.new(set_entry_params)
    @set_entry.set_number = @exercise_entry.set_entries.count + 1

    if @set_entry.save
      redirect_to @workout
    else
      redirect_to @workout, alert: "Could not add set."
    end
  end

  def update
    @exercise_entry = @workout.exercise_entries.find(params[:exercise_entry_id])
    @set_entry = @exercise_entry.set_entries.find(params[:id])

    if @set_entry.update(set_entry_params)
      redirect_to @workout
    else
      redirect_to @workout, alert: "Could not update set."
    end
  end

  def destroy
    @exercise_entry = @workout.exercise_entries.find(params[:exercise_entry_id])
    @set_entry = @exercise_entry.set_entries.find(params[:id])
    @set_entry.destroy
    redirect_to @workout
  end

  private

  def set_workout
    @workout = current_user.workouts.find(params[:workout_id])
  end

  def set_entry_params
    params.require(:set_entry).permit(:reps, :weight)
  end
end
