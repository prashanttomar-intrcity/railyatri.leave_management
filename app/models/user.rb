class User < ApplicationRecord
  has_many :leave_requests, dependent: :destroy
  has_many :leave_balances, dependent: :destroy

  has_secure_password   

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true

    # ================= ROLE METHODS =================
  def manager?
    role == "manager"
  end
end