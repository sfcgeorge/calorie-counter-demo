class UsersController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  before_action :set_user, only: [:show, :update, :destroy, :logout]
  after_action :verify_authorized, except: [:create, :login]

  skip_before_action :authenticate!, only: [:create, :login]

  def login
    if authenticate_with_http_basic do |username, password|
      if (user = User.find_by(username: username).try(:authenticate, password))
        user.regenerate_token
        render json: { id: user.id, admin: user.admin, token: user.token }
      else
        render json: { error: "Incorrect credentials" },
               status: :unauthorized
      end
    end
    else
      render json: { error: "Invalid credentials" },
             status: :unprocessable_entity
    end
  end

  def logout
    @user.regenerate_token

    head :no_content
  end

  def index
    authorize current_user
    render json: policy_scope(User)
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(valid_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(valid_params)
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy

    head :no_content
  end

  private

  def valid_params
    params.permit(:username, :password, :target_calories)
  end

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end
end
