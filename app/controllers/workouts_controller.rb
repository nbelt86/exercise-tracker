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

  def edit
    @workout = current_user.workouts.find(params[:id])
  end

  def update
    @workout = current_user.workouts.find(params[:id])

    if @workout.update(workout_params)
      redirect_to @workout
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @workout = current_user.workouts.find(params[:id])
    @workout.destroy
    redirect_to workouts_path
  end

  def duplicate
    @workout = current_user.workouts.find(params[:id])
    new_workout = current_user.workouts.new(name: @workout.name, date: Date.today)

    if new_workout.save
      @workout.exercise_entries.each do |entry|
        new_workout.exercise_entries.create(exercise: entry.exercise)
      end
      redirect_to new_workout
    else
      redirect_to @workout, alert: "Could not duplicate workout."
    end
  end

private

  def workout_params
    params.require(:workout).permit(:name, :date)
  end

end
