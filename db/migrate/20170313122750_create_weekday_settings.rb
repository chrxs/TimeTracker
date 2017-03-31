class CreateWeekdaySettings < ActiveRecord::Migration[5.0]
  def change
    create_table :weekday_settings do |t|
      t.integer :user_id
      t.string :day_of_week
      t.integer :required_minutes_logged

      t.timestamps
    end
  end
end
