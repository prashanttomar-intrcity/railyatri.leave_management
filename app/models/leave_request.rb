class LeaveRequest < ApplicationRecord
  belongs_to :user
  
  has_one_attached :medical_file
  
  validates :status, inclusion: { in: %w[pending approved rejected withdrawn] }
  validates :leave_type, presence: true
  validates :from_date, presence: true
  validates :to_date, presence: true
end