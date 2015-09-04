class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :update, :destroy]

  def index
    render json: Meal.where(user: current_user)
      .time_between(params[:time_from], params[:time_to])
      .date_between(params[:date_from], params[:date_to])
  end

  def show
    render json: @meal
  end

  def create
    @meal = current_user.meals.new(valid_params)

    if @meal.save
      render json: @meal, status: :created, location: @meal
    else
      render json: @meal.errors, status: :unprocessable_entity
    end
  end

  def update
    if @meal.update(valid_params)
      head :no_content
    else
      render json: @meal.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @meal.destroy

    head :no_content
  end

  private

  def valid_params
    params.permit(:calories, :text, :date, :time)
  end

  def set_meal
    @meal = current_user.meals.find(params[:id])
  end
end
