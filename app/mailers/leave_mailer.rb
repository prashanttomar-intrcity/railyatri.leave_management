class LeaveMailer < ApplicationMailer
  default from: "Leave Request <nardas.377450@gmail.com>"

  def new_leave_request(leave)
    @leave = leave
    @user = leave.user

    # 🔗 FRONTEND LINK
    @link = "http://localhost:3001/manager/review/#{leave.id}"

    mail(
      to: "prashant.tomar@intrcity.com", 
      subject: "📩 Leave Request | #{@user.name} (#{@leave.leave_type})"
    )
  end

  def leave_status_update(leave)
  @leave = leave
  @user = leave.user

  mail(
    to: @user.email,
    subject: "Leave #{leave.status.capitalize} | #{leave.leave_type}"
  )
end
end