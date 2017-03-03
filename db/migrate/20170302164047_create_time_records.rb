class CreateTimeRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :time_records do |t|
      t.references :project, foreign_key: true
      t.references :day, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
