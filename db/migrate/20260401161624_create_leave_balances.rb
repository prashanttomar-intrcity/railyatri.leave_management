class CreateLeaveBalances < ActiveRecord::Migration[8.1]
  def change
    create_table :leave_balances do |t|
      t.references :user, null: false, foreign_key: true
      t.string :leave_type
      t.integer :balance

      t.timestamps
    end
  end
end
