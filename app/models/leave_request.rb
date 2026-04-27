require_dependency "gds_record"

class LeaveRequest < GdsRecord
  self.table_name = "leave_management_leave_requests"

  has_one_attached :medical_file

  belongs_to :user, class_name: "User", foreign_key: "user_id", optional: true

  validates :status, inclusion: { in: %w[pending approved rejected withdrawn] }
  validates :leave_type, presence: true
  validates :from_date, presence: true
  validates :to_date, presence: true
end