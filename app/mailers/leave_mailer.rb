class LeaveMailer < ApplicationMailer
  default from: "Leave Request <nardas.377450@gmail.com>"

def new_leave_request(leave, cc_list = [])
  @leave = leave
  @user = leave.user

  # 🔗 FRONTEND LINK
  @link = "http://localhost:3001/manager/review/#{leave.id}"

  # 🔥 FIND MANAGER FROM STAGING DB
  manager = User.find_by(id: @user.manager_id)

  # ⚠️ SAFETY CHECK
  return unless manager.present?

  # 📎 ATTACH FILE IF SICK LEAVE
  if @leave.leave_type == "Sick Leave" && @leave.medical_file.attached?
    attachments[@leave.medical_file.filename.to_s] = @leave.medical_file.download
  end

mail(
  to: manager.email,
  cc: cc_list.presence,
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