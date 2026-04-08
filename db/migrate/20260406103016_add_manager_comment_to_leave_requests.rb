class AddManagerCommentToLeaveRequests < ActiveRecord::Migration[8.1]
  def change
    add_column :leave_requests, :manager_comment, :text
  end
end
