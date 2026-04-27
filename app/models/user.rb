require_dependency "gds_record"

class User < GdsRecord
  self.table_name = 'bus_members'

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true
end