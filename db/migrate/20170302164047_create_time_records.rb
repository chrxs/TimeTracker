class CreateTimeRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :time_records do |t|
      t.integer :project_id
      t.integer :day_id
      t.integer :amount

      t.timestamps
    end
  end
end
