class CreateTimeRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :time_records do |t|
      t.belongs_to :project
      t.belongs_to :day
      t.integer :amount

      t.timestamps
    end
  end
end
