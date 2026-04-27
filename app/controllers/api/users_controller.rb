class Api::UsersController < ApplicationController
  def index
    users = User.select(:id, :name, :email)
    render json: users
  end
end