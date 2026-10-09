class ExercisesController < ApplicationController
  def index
    @query = params[:query]
    @exercises = Exercise.all

    if @query.present?
      search_term = "%#{@query.downcase}%"
      @exercises = @exercises.where(
        "LOWER(name) LIKE :term OR LOWER(muscles_target) LIKE :term", term: search_term
      )
    end
  end

  def show
    @exercise = Exercise.find(params[:id])
  end
end
