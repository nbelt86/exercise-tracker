class SetEntriesController < ApplicationController
  def create
    @exercise_entry = ExerciseEntry.find(params[:exercise_entry_id])
    @set_entry = @exercise_entry.set_entries.new(set_entry_params)
    @set_entry.set_number = @exercise_entry.set_entries.count + 1

    if @set_entry.save
      redirect_to workout_path(params[:workout_id])
    else
      redirect_to workout_path(params[:workout_id]), alert: "Could not add set."
    end
  end

  def update
    @set_entry = SetEntry.find(params[:id])

    if @set_entry.update(set_entry_params)
      redirect_to workout_path(params[:workout_id])
    else
      redirect_to workout_path(params[:workout_id]), alert: "Could not update set."
    end
  end

  def destroy
    @set_entry = SetEntry.find(params[:id])
    @set_entry.destroy
    redirect_to workout_path(params[:workout_id])
  end

  private

  def set_entry_params
    params.require(:set_entry).permit(:reps, :weight)
  end
end
