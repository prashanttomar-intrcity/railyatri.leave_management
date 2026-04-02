class LeaveRequest < ApplicationRecord
  belongs_to :user
  
  validates :status, inclusion: { in: %w[pending approved rejected withdrawn] }
  validates :leave_type, presence: true
  validates :from_date, presence: true
  validates :to_date, presence: true
end