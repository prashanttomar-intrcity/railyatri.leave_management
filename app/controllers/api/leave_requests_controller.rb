class Api::LeaveRequestsController < ApplicationController
  skip_before_action :verify_authenticity_token

def index
  leaves = LeaveRequest.where(user_id: params[:user_id])
  render json: leaves
end

  def create
  
  data = params[:leave_request] || params

  leave = LeaveRequest.new(
    user_id: data[:user_id],
    leave_type: data[:leave_type],
    from_date: data[:from_date],
    to_date: data[:to_date],
    days: data[:days],
    reason: data[:reason],
    status: data[:status],
    applying_to: data[:applying_to],
    contact: data[:contact]
  )

  if leave.save
    render json: leave, status: :created
  else
    render json: { errors: leave.errors.full_messages }, status: :unprocessable_entity
  end
end

  def update
    leave = LeaveRequest.find(params[:id])
    leave.update(status: params[:status])
    render json: leave
  end

  def destroy
    leave = LeaveRequest.find(params[:id])
    leave.destroy
    render json: { message: "Deleted successfully" }
  end

  private

  def leave_params
  params.permit(
    :user_id,
    :leave_type,
    :from_date,
    :to_date,
    :days,
    :reason,
    :status,
    :applying_to,
    :contact
  )
end
end