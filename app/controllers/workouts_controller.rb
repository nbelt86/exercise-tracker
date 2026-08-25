class WorkoutsController < ApplicationController
  def index
    @workouts = Workout.all
  end

  def show
    @workout = Workout.find(params[:id])
    @exercise_entry = ExerciseEntry.new(workout: @workout)
    @exercises = Exercise.all
  end

  def new
    @workout = Workout.new

  end

  def create
    @workout = Workout.new(workout_params)

    if @workout.save
      redirect_to @workout
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @workout = Workout.find(params[:id])
    @workout.destroy
    redirect_to workouts_path
  end

private

  def workout_params
    params.require(:workout).permit(:name, :date)
  end

end
