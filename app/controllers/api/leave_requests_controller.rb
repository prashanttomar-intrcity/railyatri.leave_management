class Api::LeaveRequestsController < ApplicationController
  skip_before_action :verify_authenticity_token

def index
  leaves = LeaveRequest.where(user_id: params[:user_id])
  render json: leaves
end

def all_leaves
  manager_id = params[:manager_id]

  # Step 1: find users whose manager is current user
  employees = User.where(manager_id: manager_id).pluck(:id)

  # Step 2: INCLUDE SELF (IMPORTANT FIX)
  employees << manager_id.to_i

  # Step 2: get their leaves
  leaves = LeaveRequest.where(user_id: employees)
                       .includes(:user)
                       .order(created_at: :desc)

  render json: leaves.as_json(include: { user: { only: [:id, :name, :email] } })
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

  if params[:medical_file].present?
    leave.medical_file.attach(params[:medical_file])
  end
  cc_list = []

if params[:cc].present?
  begin
    cc_list = JSON.parse(params[:cc])
  rescue
    cc_list = []
  end
end

LeaveMailer.new_leave_request(leave, cc_list).deliver_now

  render json: leave, status: :created
  else
    render json: { errors: leave.errors.full_messages }, status: :unprocessable_entity
  end
end

  def update
  leave = LeaveRequest.find(params[:id])

  leave.update(
    status: params[:status],
    manager_comment: params[:manager_comment]
  )
  
  LeaveMailer.leave_status_update(leave).deliver_now
  
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
    :contact,
    :medical_file
  )
end
end