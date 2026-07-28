class ExerciseEntriesController < ApplicationController
  def create
    @workout = Workout.find(params[:workout_id])
    @exercise_entry = @workout.exercise_entries.new(exercise_entry_params)

    if @exercise_entry.save
      redirect_to @workout
    else
      redirect_to @workout, alert: "Could not add exercise."
    end
  end

  def destroy
    @workout = Workout.find(params[:workout_id])
    @exercise_entry = @workout.exercise_entries.find(params[:id])
    @exercise_entry.destroy
    redirect_to @workout
  end

  private

  def exercise_entry_params
    params.require(:exercise_entry).permit(:exercise_id)
  end
end
