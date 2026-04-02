class CreateHolidays < ActiveRecord::Migration[8.1]
  def change
    create_table :holidays do |t|
      t.string :name
      t.date :date
      t.boolean :optional

      t.timestamps
    end
  end
end
