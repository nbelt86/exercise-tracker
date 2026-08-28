class WorkoutsController < ApplicationController
  def index
    @workouts = current_user.workouts
  end

  def show
    @workout = current_user.workouts.find(params[:id])
    @exercise_entry = ExerciseEntry.new(workout: @workout)
    @exercises = Exercise.all
  end

  def new
    @workout = Workout.new(date: Date.today)
  end

  def create
    @workout = current_user.workouts.new(workout_params)

    if @workout.save
      redirect_to @workout
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @workout = current_user.workouts.find(params[:id])
    @workout.destroy
    redirect_to workouts_path
  end

private

  def workout_params
    params.require(:workout).permit(:name, :date)
  end

end
