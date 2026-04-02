class Api::AuthController < ApplicationController
  skip_before_action :verify_authenticity_token

  # ================= SIGNUP =================
  def signup
    user = User.new(user_params)

    if user.save
      render json: { message: "Signup successful", user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # ================= LOGIN =================
  def login
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])  
      render json: { message: "Login successful", user: user }
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password)   
  end
end