class DropHolidaysAndLeaveBalances < ActiveRecord::Migration[8.1]
  def change
    drop_table :holidays, if_exists: true
    drop_table :leave_balances, if_exists: true
  end
end