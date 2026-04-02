class CreateLeaveRequests < ActiveRecord::Migration[8.1]
  def change
    create_table :leave_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.string :leave_type
      t.date :from_date
      t.date :to_date
      t.integer :days
      t.text :reason
      t.string :status
      t.string :applying_to
      t.string :contact

      t.timestamps
    end
  end
end
